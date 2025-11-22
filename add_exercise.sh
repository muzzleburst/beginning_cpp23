#!/bin/bash
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
