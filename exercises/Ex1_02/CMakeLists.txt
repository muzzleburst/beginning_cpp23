# Ex1_02
add_executable(Ex1_02 Ex1_02.cpp)

# Enable modules and use the module mapper
target_compile_options(Ex1_02 PRIVATE 
    -fmodules-ts
    -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map
)
