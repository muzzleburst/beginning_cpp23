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

if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    echo "Example: $0 MyProject"
    exit 1
fi

PROJECT_NAME=$1
PROJECT_DIR="projects/$PROJECT_NAME"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create project directory
mkdir -p "$PROJECT_DIR"

# Create source file
cat > "$PROJECT_DIR/${PROJECT_NAME}.cpp" << 'EOF'
/*
Personal project file

Copyright (c) 2025 Robert Graf
*/

import std;

int main()
{
    std::println("Hello from {}!", "PROJECT_NAME_PLACEHOLDER");
    return 0;
}
EOF

sed -i "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "$PROJECT_DIR/${PROJECT_NAME}.cpp"

# Update CMakeLists.txt to add the new project
if ! grep -q "# Custom projects" CMakeLists.txt; then
    cat >> CMakeLists.txt << 'EOF'

# Custom projects (user-created)
EOF
fi

# Add the project to CMakeLists.txt
cat >> CMakeLists.txt << EOF

# $PROJECT_NAME
add_executable($PROJECT_NAME "projects/$PROJECT_NAME/${PROJECT_NAME}.cpp")
target_compile_options($PROJECT_NAME PRIVATE 
    -fmodules-ts
    -fmodule-mapper=\${CMAKE_SOURCE_DIR}/module.map
)
EOF

# Add launch configuration to .vscode/launch.json
if [ -f .vscode/launch.json ]; then
    # Create a temporary file with the new configuration
    python3 - <<PYTHON_SCRIPT
import json

with open('.vscode/launch.json', 'r') as f:
    data = json.load(f)

# Add run configuration
data['configurations'].append({
    'name': '$PROJECT_NAME: Run (No Debug)',
    'type': 'node-terminal',
    'request': 'launch',
    'command': '\${workspaceFolder}/build/$PROJECT_NAME',
    'cwd': '\${workspaceFolder}',
    'preLaunchTask': 'CMake: Build'
})

# Add debug configuration
data['configurations'].append({
    'name': '$PROJECT_NAME: Debug',
    'type': 'cppdbg',
    'request': 'launch',
    'program': '\${workspaceFolder}/build/$PROJECT_NAME',
    'args': [],
    'stopAtEntry': False,
    'cwd': '\${workspaceFolder}',
    'environment': [],
    'externalConsole': False,
    'MIMode': 'gdb',
    'preLaunchTask': 'CMake: Build'
})

with open('.vscode/launch.json', 'w') as f:
    json.dump(data, f, indent=4)
PYTHON_SCRIPT
fi

# Add run task to .vscode/tasks.json
if [ -f .vscode/tasks.json ]; then
    python3 - <<PYTHON_SCRIPT
import json

with open('.vscode/tasks.json', 'r') as f:
    content = f.read()
    # Remove comment markers for JSON parsing
    lines = content.split('\n')
    clean_lines = []
    for line in lines:
        # Keep lines that aren't pure comments
        if not line.strip().startswith('//'):
            clean_lines.append(line)
    clean_content = '\n'.join(clean_lines)
    
try:
    data = json.loads(clean_content)
except:
    # If JSON parsing fails, just skip updating tasks
    import sys
    sys.exit(0)

# Add run task
data['tasks'].append({
    'type': 'shell',
    'label': 'Run: $PROJECT_NAME',
    'command': '\${workspaceFolder}/build/$PROJECT_NAME',
    'options': {
        'cwd': '\${workspaceFolder}'
    },
    'dependsOn': ['CMake: Build'],
    'problemMatcher': [],
    'presentation': {
        'echo': True,
        'reveal': 'always',
        'focus': False,
        'panel': 'shared',
        'showReuseMessage': False,
        'clear': False
    },
    'detail': 'Run $PROJECT_NAME without debugging'
})

with open('.vscode/tasks.json', 'w') as f:
    json.dump(data, f, indent=4)
PYTHON_SCRIPT
fi

echo "✓ Created project: $PROJECT_NAME"
echo "  Location: $PROJECT_DIR"
echo "  Source: $PROJECT_DIR/${PROJECT_NAME}.cpp"
echo ""
echo "Next steps:"
echo "  1. Edit $PROJECT_DIR/${PROJECT_NAME}.cpp"
echo "  2. Run 'cmake -B build -S .' to configure"
echo "  3. Run 'cmake --build build' to build"
echo "  4. Run './build/$PROJECT_NAME' to execute"
echo ""
echo "Or use VS Code:"
echo "  - Press Ctrl+Shift+B to build"
echo "  - Press Ctrl+F5 to run (select $PROJECT_NAME configuration)"
