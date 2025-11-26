# Beginning C++23 Build Configuration

A VS Code build configuration for working with examples from [Beginning C++23](https://github.com/Apress/beginning-cpp23), Seventh Edition, by Ivor Horton and Peter Van Weert (Apress).

**Important**: This repository contains only build configuration and VS Code settings. The actual source code examples and exercises are kept separate via the repository linked above.

## Prerequisites

- GCC with C++23 module support
- CMake 3.31.6 or later
- VS Code with C/C++ extension (recommended)
- Git (for cloning the Apress source repository)

## Tested Environment

This project has been tested on:
- **OS**: Ubuntu 25.10
- **Compiler**: GCC 15.2.0
- **IDE**: VS Code 1.106.2

## Project Structure

```
~/Documents/
├── beginning_cpp23/              # This repository (build config only)
│   ├── .vscode/                  # VS Code configuration
│   ├── CMakeLists.txt           # Build configuration
│   ├── module.map.in            # Module mapper template
│   ├── setup_source.sh          # Script to clone Apress repo
│   ├── gcm.cache/               # Generated C++ module cache
│   ├── build/                   # Generated build files
│   └── README.md                # This file
│
└── beginning-cpp23-source/      # Apress repository (auto-cloned)
    ├── Examples/                # Source code examples
    │   ├── Chapter 01/
    │   ├── Chapter 02/
    │   └── ...
    └── Exercises/               # Exercise files
```

## Initial Setup

### 1. Clone the Apress Source Repository

Before building, you must clone the official Apress repository containing the source code examples.

#### Using VS Code (Recommended)

1. Press `Ctrl+Shift+P` to open the Command Palette
2. Type "Tasks: Run Task"
3. Select "Setup: Clone Apress Source Repository"

#### Using Command Line

```bash
./setup_source.sh
```

This will clone the Apress repository to `../beginning-cpp23-source/` (a sibling directory).

### 2. Build the GCM Cache

Generate the GCM cache for the C++ standard library module:

#### Using VS Code (Recommended)

1. Press `Ctrl+Shift+P` to open the Command Palette
2. Type "Tasks: Run Task"
3. Select "Build GCM Cache for std"

#### Using Command Line

```bash
mkdir -p gcm.cache
g++ -std=c++26 -O2 -fmodules -fsearch-include-path -fmodule-only -c bits/std.cc -o gcm.cache/std.gcm
```

## Building

### Using VS Code Tasks

- **Build Project**: Press `Ctrl+Shift+B` or run task "CMake: Build"
- **Configure CMake**: Run task "CMake: Configure"
- **Clean Project**: Run task "Clean Project" (removes build/, gcm.cache/, module.map)

### Using Command Line

```bash
# Configure and build
cmake -B build -S . -G "Unix Makefiles"
cmake --build build
```

## Running Examples

The project includes 93 working examples from Chapters 1-10. Some examples are intentionally excluded because they're teaching examples that demonstrate errors (Ex8_02, Ex8_09A-C, Ex8_18, Ex8_19A-C).

### Using VS Code

- **Run without debugging**: Press `Ctrl+F5` or use the Run tasks
- **Debug**: Press `F5` (uses GDB)

### Using Command Line

```bash
# Run any example by name
./build/Ex1_01
./build/Ex2_01
./build/Ex5_10

# Build a specific example
cmake --build build --target Ex3_02
```

## Available Examples

- **Chapter 1**: Ex1_01
- **Chapter 2**: Ex2_01 through Ex2_08A (15 examples)
- **Chapter 3**: Ex3_01 through Ex3_03 (3 examples)
- **Chapter 4**: Ex4_01 through Ex4_10 (13 examples)
- **Chapter 5**: Ex5_01 through Ex5_16 (21 examples)
- **Chapter 6**: Ex6_01 through Ex6_07 (7 examples)
- **Chapter 7**: Ex7_01 through Ex7_07 (9 examples)
- **Chapter 8**: Ex8_01, Ex8_03-Ex8_08, Ex8_10-Ex8_17 (17 examples, 7 excluded*)
- **Chapter 9**: Ex9_01 through Ex9_04A (5 examples)
- **Chapter 10**: Ex10_01 through Ex10_05 (6 examples)

**Total: 93 working examples**

*Excluded examples are teaching examples that intentionally demonstrate compilation errors.

Run `cmake --build build` to build all examples, or build specific targets as shown above.

## Adding More Examples

Chapters 1-10 (104 examples) are already included. Chapters 11-21 contain multi-file examples with custom modules (.cppm files) that require additional CMake configuration.

To add a Chapter 11+ example, you'll need to:

1. Create a custom CMake function to handle multi-file builds
2. Add module dependencies
3. Configure proper include paths

Example structure for a multi-file example:
```cmake
add_executable(Ex11_01 
    "${APRESS_SOURCE_DIR}/Examples/Chapter 11/Ex11_01/Ex11_01.cpp"
    "${APRESS_SOURCE_DIR}/Examples/Chapter 11/Ex11_01/math.cppm"
)
```

Then update `.vscode/launch.json` and `.vscode/tasks.json` if you want VS Code run/debug configurations.

## C++ Modules Support

This project uses C++23 modules with `import std;`. The GCM cache must be built before the project can compile. If you update your compiler or the cache becomes corrupted, re-run the "Build GCM Cache for std" task.

## Notes

- IntelliSense error squiggles are disabled due to lack of C++23 module support in the C/C++ extension
- The project uses Unix Makefiles as the CMake generator (not Ninja) to avoid generator conflicts
- Clean the build directory if you encounter generator mismatch errors: `rm -rf build`
- Source code remains in the separate `beginning-cpp23-source` directory and is not committed to this repository

## Licenses

Please check individual files for license and copyright information.

- **This repository** (build configuration): See license headers in individual files
- **Apress source code**: Licensed under the terms in the [Apress repository](https://github.com/Apress/beginning-cpp23)
