#!/bin/bash
# Source this file to enter the easybuild live or test environment.

env='test'
while [[ -n $1 ]]; do
    case $1 in
    --live)
        env='live'
        ;;
    esac
    shift
done

module load EasyBuild

repo=${HOME}/easybuild/sulis-eb

if [[ "X${env}" == "Xlive" ]]; then
	appbase=/sulis/institutions/birmingham
else
	appbase=${HOME}/easybuild/install
fi

export EASYBUILD_INSTALLPATH=${appbase}
module use "${appbase}"/modules/all
module use "${appbase}"/modules/
export EASYBUILD_ACCEPT_EULA_FOR=Intel-oneAPI,NVHPC
export EASYBUILD_SOURCEPATH=${HOME}/easybuild/sources
export EASYBUILD_BUILDPATH=/dev/shm/${USER}/build
export EASYBUILD_TMPDIR=/dev/shm/${USER}/tmp

unset LD_RUN_PATH
unset C_INCLUDE_PATH
unset CPLUS_INCLUDE_PATH

echo -e "Loading easybuild \033[1;33m${env}\033[0m environment"
echo "Using installation location ${appbase}"

# add custom easyconfigs to the search path - the trailing : prepends the search path for easyconfigs
export EASYBUILD_ROBOT_PATHS=${repo}/easyconfigs:

# add custom easyblocks to the relevant search path
export EASYBUILD_INCLUDE_EASYBLOCKS=${repo}/easyblocks/\*.py,${repo}/easyblocks/generic/\*.py

# a100 - 8.0 (https://en.wikipedia.org/wiki/CUDA#GPUs_supported)
export EASYBUILD_CUDA_COMPUTE_CAPABILITIES="8.0"

