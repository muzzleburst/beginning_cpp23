# Beginning C++23

A collection of C++23 exercises and examples using C++ modules (`import std;`).

This repository contains personal learning experiences from [Beginning C++23](https://github.com/Apress/beginning-cpp23), Seventh Edition, by Ivor Horton and Peter Van Weert (Apress).

## Prerequisites

- GCC 15.2.0 or later (with C++23/26 module support)
- CMake 3.31.6 or later
- VS Code with C/C++ extension (recommended)

## Tested Environment

This project has been tested on:
- **OS**: Ubuntu 25.10
- **Compiler**: GCC 15.2.0

## Project Structure

- `exercises/` - Individual exercise subdirectories
  - `Ex1_01/` - Hello World program
  - `Ex1_02/` - Second exercise
- `gcm.cache/` - Pre-compiled module cache for `std` module
- `module.map` - Module mapper configuration
- `add_exercise.sh` - Script to automate exercise creation

## Initial Setup

Before building the project for the first time, you need to generate the GCM cache for the C++ standard library module.

### Using VS Code (Recommended)

1. Press `Ctrl+Shift+P` to open the Command Palette
2. Type "Tasks: Run Task"
3. Select "Build GCM Cache for std"

This will create `gcm.cache/std.gcm` which is required for `import std;` to work.

### Using Command Line

```bash
mkdir -p gcm.cache
g++ -std=c++26 -O2 -fmodules -fsearch-include-path -fmodule-only -c bits/std.cc -o gcm.cache/std.gcm
```

## Building

### Using VS Code Tasks

- **Build Project**: Press `Ctrl+Shift+B` or run task "CMake: Build"
- **Configure CMake**: Run task "CMake: Configure"
- **Run Exercise 1**: Run task "Run: Ex1_01"
- **Run Exercise 2**: Run task "Run: Ex1_02"

### Using Command Line

```bash
# Configure and build
cmake -B build -S . -G "Unix Makefiles"
cmake --build build
```

## Running Exercises

### Using VS Code

- **Run without debugging**: Press `Ctrl+F5` or use the Run tasks
- **Debug**: Press `F5` (uses GDB)

### Using Command Line

```bash
./build/exercises/Ex1_01/Ex1_01
./build/exercises/Ex1_02/Ex1_02
```

## Adding New Exercises

### Automated Method (Recommended)

```bash
./add_exercise.sh Ex1_03
```

This script will:
- Create the exercise directory structure
- Generate a template source file with `import std;`
- Create a CMakeLists.txt with module support
- Update the root CMakeLists.txt
- Add a launch configuration to VS Code

### Manual Method

1. Create a new directory under `exercises/`
2. Add your source files and a `CMakeLists.txt`
3. Configure CMake with module support:
   ```cmake
   target_compile_options(YourExercise PRIVATE -fmodules-ts -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map)
   ```
4. Add `add_subdirectory(exercises/your_exercise)` to the root `CMakeLists.txt`

## C++ Modules Support

This project uses C++23 modules with `import std;`. The GCM cache must be built before the project can compile. If you update your compiler or the cache becomes corrupted, re-run the "Build GCM Cache for std" task.

## Notes

- IntelliSense error squiggles are disabled due to lack of C++23 module support in the C/C++ extension
- The project uses Unix Makefiles as the CMake generator (not Ninja) to avoid generator conflicts
- Clean the build directory if you encounter generator mismatch errors: `rm -rf build`
