cmake_minimum_required(VERSION 3.28)
project(BeginningCpp23 VERSION 1.0 LANGUAGES CXX)

# Set C++23 standard
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add subdirectories for each exercise
add_subdirectory(exercises/Ex1_01)
add_subdirectory(exercises/Ex1_02)
