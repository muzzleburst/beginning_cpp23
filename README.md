# Beginning C++23

A collection of C++23 exercises and examples.

## Project Structure

- `exercises/` - Individual exercise subdirectories
  - `Ex1_01/` - Hello World program

## Building

This project uses CMake:

```bash
# Configure and build
cmake -B build -S .
cmake --build build

# Or use VS Code tasks (Ctrl+Shift+B)
```

## Running

- Use VS Code: Press `Ctrl+F5` to run without debugging
- Or run directly: `./build/exercises/Ex1_01/Ex1_01`

## Adding New Exercises

1. Create a new directory under `exercises/`
2. Add your source files and a `CMakeLists.txt`
3. Add `add_subdirectory(exercises/your_exercise)` to the root `CMakeLists.txt`
