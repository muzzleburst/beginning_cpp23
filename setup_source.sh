#!/bin/bash
#
# Freeware License, some rights reserved
#
# Copyright (c) 2025 Robert Graf
#
# Permission is hereby granted, free of charge, to anyone obtaining a copy 
# of this software and associated documentation files (the "Software"), 
# to work with the Software within the limits of freeware distribution and fair use. 
# This includes the rights to use, copy, and modify the Software for personal use. 
# Users are also allowed and encouraged to submit corrections and modifications 
# to the Software for the benefit of other users.
#
# It is not allowed to reuse,  modify, or redistribute the Software for 
# commercial use in any way, or for a user's educational materials such as books 
# or blog articles without prior permission from the copyright holder. 
#
# The above copyright notice and this permission notice need to be included 
# in all copies or substantial portions of the software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS OR APRESS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/../beginning-cpp23-source"
REPO_URL="https://github.com/Apress/beginning-cpp23.git"

echo "Setting up Beginning C++23 source files..."
echo

if [ -d "$SOURCE_DIR" ]; then
    echo "Source directory already exists at: $SOURCE_DIR"
    echo "Updating repository..."
    cd "$SOURCE_DIR"
    git pull
else
    echo "Cloning Apress Beginning C++23 repository..."
    echo "Target: $SOURCE_DIR"
    git clone "$REPO_URL" "$SOURCE_DIR"
fi

echo
echo "Setup complete!"
echo "Source files are located at: $SOURCE_DIR"
echo "You can now build the project using CMake."
