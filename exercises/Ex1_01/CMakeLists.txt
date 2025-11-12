# Exercise 1.01: Hello World
add_executable(Ex1_01 Ex1_01.cpp)

# Enable modules and use the module mapper
target_compile_options(Ex1_01 PRIVATE 
    -fmodules-ts
    -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map
)

