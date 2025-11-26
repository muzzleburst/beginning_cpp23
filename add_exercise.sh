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
# Script to create a new exercise in the beginning_cpp23 project

if [ -z "$1" ]; then
    echo "Usage: ./add_exercise.sh <exercise_name>"
    echo "Example: ./add_exercise.sh Ex1_02"
    exit 1
fi

EXERCISE_NAME=$1
EXERCISE_DIR="exercises/$EXERCISE_NAME"

# Create exercise directory
if [ -d "$EXERCISE_DIR" ]; then
    echo "Error: Exercise $EXERCISE_NAME already exists!"
    exit 1
fi

mkdir -p "$EXERCISE_DIR"

# Create the C++ source file
cat > "$EXERCISE_DIR/${EXERCISE_NAME}.cpp" << 'EOF'
import std;

int main()
{
    std::println("Hello from ${EXERCISE_NAME}!");
    return 0;
}
EOF

# Replace the placeholder with actual exercise name
sed -i "s/\${EXERCISE_NAME}/$EXERCISE_NAME/g" "$EXERCISE_DIR/${EXERCISE_NAME}.cpp"

# Create CMakeLists.txt
cat > "$EXERCISE_DIR/CMakeLists.txt" << EOF
# $EXERCISE_NAME
add_executable($EXERCISE_NAME ${EXERCISE_NAME}.cpp)

# Enable modules and use the module mapper
target_compile_options($EXERCISE_NAME PRIVATE 
    -fmodules-ts
    -fmodule-mapper=\${CMAKE_SOURCE_DIR}/module.map
)
EOF

# Add to root CMakeLists.txt
echo "add_subdirectory(exercises/$EXERCISE_NAME)" >> CMakeLists.txt

# Add to launch.json
LAUNCH_JSON=".vscode/launch.json"
# Remove the closing brackets and add new configuration
sed -i '$d' "$LAUNCH_JSON"  # Remove last line ]
sed -i '$d' "$LAUNCH_JSON"  # Remove last line }

cat >> "$LAUNCH_JSON" << EOF
        },
        {
            "name": "$EXERCISE_NAME",
            "type": "cppdbg",
            "request": "launch",
            "program": "\${workspaceFolder}/build/exercises/$EXERCISE_NAME/$EXERCISE_NAME",
            "args": [],
            "stopAtEntry": false,
            "cwd": "\${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "preLaunchTask": "CMake: Build"
        }
    ]
}
EOF

echo "✓ Created exercise: $EXERCISE_NAME"
echo "  - Source: $EXERCISE_DIR/${EXERCISE_NAME}.cpp"
echo "  - CMakeLists: $EXERCISE_DIR/CMakeLists.txt"
echo "  - Added to root CMakeLists.txt"
echo "  - Added launch configuration"
echo ""
echo "Next steps:"
echo "  1. Edit $EXERCISE_DIR/${EXERCISE_NAME}.cpp"
echo "  2. Run: cmake -B build -S ."
echo "  3. Build: cmake --build build"
echo "  4. Or press Ctrl+Shift+B in VS Code"
