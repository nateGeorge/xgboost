#!/bin/bash

make -f dmlc-core/scripts/packages.mk lz4

source $HOME/miniconda/bin/activate

if [ ${TASK} == "python_sdist_test" ]; then
    set -e

    conda activate python3
    python --version
    cmake --version

    make pippack
    python -m pip install xgboost-*.tar.gz -v --user
    python -c 'import xgboost' || exit -1
fi

if [ ${TASK} == "python_test" ]; then
    if grep -n -R '<<<.*>>>\(.*\)' src include | grep --invert "NOLINT"; then
        echo 'Do not use raw CUDA execution configuration syntax with <<<blocks, threads>>>.' \
             'try `dh::LaunchKernel`'
        exit -1
    fi

    set -e

if [ ${TASK} == "s390x_test" ]; then
    set -e

    # Build and run C++ tests
    rm -rf build
    mkdir build && cd build
    cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON -DGOOGLE_TEST=ON -DUSE_OPENMP=ON -DUSE_DMLC_GTEST=ON -GNinja
    time ninja -v
    ./testxgboost
fi
