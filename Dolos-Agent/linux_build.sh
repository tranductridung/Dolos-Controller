#!/bin/sh

# For Unix (OSX and Linux)

# Set Python 3.7 as the default for CMake
export PYTHON_EXECUTABLE=$(which python3.7)

# Create folder and generate Eclipse project
mkdir -p build
cd build
cmake .. -G "Unix Makefiles" -DPYTHON_EXECUTABLE=$PYTHON_EXECUTABLE

# Build project
make -j 4

