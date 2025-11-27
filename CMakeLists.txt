#[[
Freeware License, some rights reserved

Copyright (c) 2025 Robert Graf

Permission is hereby granted, free of charge, to anyone obtaining a copy 
of this software and associated documentation files (the "Software"), 
to work with the Software within the limits of freeware distribution and fair use. 
This includes the rights to use, copy, and modify the Software for personal use. 
Users are also allowed and encouraged to submit corrections and modifications 
to the Software for the benefit of other users.

It is not allowed to reuse,  modify, or redistribute the Software for 
commercial use in any way, or for a user's educational materials such as books 
or blog articles without prior permission from the copyright holder. 

The above copyright notice and this permission notice need to be included 
in all copies or substantial portions of the software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS OR APRESS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

cmake_minimum_required(VERSION 3.28)
project(BeginningCpp23 VERSION 1.0 LANGUAGES CXX)

# Set C++23 standard
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Generate module.map with the correct absolute path
configure_file(
    ${CMAKE_SOURCE_DIR}/module.map.in
    ${CMAKE_SOURCE_DIR}/module.map
    @ONLY
)

# Path to external source directory
set(APRESS_SOURCE_DIR "${CMAKE_SOURCE_DIR}/../beginning-cpp23-source")

# Check if source directory exists
if(NOT EXISTS "${APRESS_SOURCE_DIR}")
    message(FATAL_ERROR 
        "Source directory not found: ${APRESS_SOURCE_DIR}\n"
        "Please run ./setup_source.sh to clone the Apress repository.")
endif()

# Function to add an example from the Apress repository
function(add_example chapter_num example_name)
    set(SOURCE_FILE "${APRESS_SOURCE_DIR}/Examples/Chapter ${chapter_num}/${example_name}.cpp")
    
    if(EXISTS "${SOURCE_FILE}")
        add_executable(${example_name} "${SOURCE_FILE}")
        
        # Enable modules and use the module mapper
        target_compile_options(${example_name} PRIVATE 
            -fmodules-ts
            -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map
        )
        
        message(STATUS "Added example: ${example_name}")
    else()
        message(WARNING "Source file not found: ${SOURCE_FILE}")
    endif()
endfunction()

# Add examples from all chapters (Chapters 1-10 have single-file examples)

# Chapter 01
add_example("01" "Ex1_01")

# Chapter 02
add_example("02" "Ex2_01")
add_example("02" "Ex2_02")
add_example("02" "Ex2_03")
add_example("02" "Ex2_04")
add_example("02" "Ex2_04A")
add_example("02" "Ex2_04B")
add_example("02" "Ex2_04C")
add_example("02" "Ex2_04D")
add_example("02" "Ex2_04E")
add_example("02" "Ex2_05")
add_example("02" "Ex2_06")
add_example("02" "Ex2_07")
add_example("02" "Ex2_08")
add_example("02" "Ex2_08A")

# Chapter 03
add_example("03" "Ex3_01")
add_example("03" "Ex3_02")
add_example("03" "Ex3_03")

# Chapter 04
add_example("04" "Ex4_01")
add_example("04" "Ex4_02")
add_example("04" "Ex4_02A")
add_example("04" "Ex4_03")
add_example("04" "Ex4_04")
add_example("04" "Ex4_04A")
add_example("04" "Ex4_05")
add_example("04" "Ex4_06")
add_example("04" "Ex4_07")
add_example("04" "Ex4_08")
add_example("04" "Ex4_09")
add_example("04" "Ex4_09A")
add_example("04" "Ex4_10")

# Chapter 05
add_example("05" "Ex5_01")
add_example("05" "Ex5_02")
add_example("05" "Ex5_03")
add_example("05" "Ex5_03A")
add_example("05" "Ex5_03B")
add_example("05" "Ex5_04")
add_example("05" "Ex5_04A")
add_example("05" "Ex5_05")
add_example("05" "Ex5_06")
add_example("05" "Ex5_07")
add_example("05" "Ex5_07A")
add_example("05" "Ex5_08")
add_example("05" "Ex5_09")
add_example("05" "Ex5_10")
add_example("05" "Ex5_11")
add_example("05" "Ex5_12")
add_example("05" "Ex5_12A")
add_example("05" "Ex5_13")
add_example("05" "Ex5_14")
add_example("05" "Ex5_15")
add_example("05" "Ex5_16")

# Chapter 06
add_example("06" "Ex6_01")
add_example("06" "Ex6_02")
add_example("06" "Ex6_03")
add_example("06" "Ex6_04")
add_example("06" "Ex6_05")
add_example("06" "Ex6_06")
add_example("06" "Ex6_07")

# Chapter 07
add_example("07" "Ex7_01")
add_example("07" "Ex7_01A")
add_example("07" "Ex7_02")
add_example("07" "Ex7_02A")
add_example("07" "Ex7_03")
add_example("07" "Ex7_04")
add_example("07" "Ex7_05")
add_example("07" "Ex7_06")
add_example("07" "Ex7_07")

# Chapter 08
add_example("08" "Ex8_01")
# Ex8_02 - intentionally broken (missing function prototype)
# add_example("08" "Ex8_02")
add_example("08" "Ex8_03")
add_example("08" "Ex8_04")
add_example("08" "Ex8_05")
add_example("08" "Ex8_05A")
add_example("08" "Ex8_06")
add_example("08" "Ex8_06A")
add_example("08" "Ex8_07")
add_example("08" "Ex8_08")
# Ex8_09A, Ex8_09B, Ex8_09C - intentionally problematic (teaching examples)
# add_example("08" "Ex8_09A")
# add_example("08" "Ex8_09B")
# add_example("08" "Ex8_09C")
add_example("08" "Ex8_10")
add_example("08" "Ex8_11")
add_example("08" "Ex8_12")
add_example("08" "Ex8_13")
add_example("08" "Ex8_14")
add_example("08" "Ex8_15")
add_example("08" "Ex8_16")
add_example("08" "Ex8_17")
# Ex8_18 - intentionally broken (missing constexpr)
# add_example("08" "Ex8_18")
# Ex8_19A, Ex8_19B, Ex8_19C - intentionally problematic (constexpr teaching examples)
# add_example("08" "Ex8_19A")
# add_example("08" "Ex8_19B")
# add_example("08" "Ex8_19C")

# Chapter 09
add_example("09" "Ex9_01")
add_example("09" "Ex9_02")
add_example("09" "Ex9_03")
add_example("09" "Ex9_04")
add_example("09" "Ex9_04A")

# Chapter 10
add_example("10" "Ex10_01")
add_example("10" "Ex10_02")
add_example("10" "Ex10_03")
add_example("10" "Ex10_03A")
add_example("10" "Ex10_04")
add_example("10" "Ex10_05")

# Note: Chapters 11-21 have multi-file examples with module files (.cppm)
# These require more complex CMake configuration and will be added later.

# Custom projects (user-created)

# test_increment_side_effects
add_executable(test_increment_side_effects "projects/test_increment_side_effects/test_increment_side_effects.cpp")
target_compile_options(test_increment_side_effects PRIVATE 
    -fmodules-ts
    -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map
)

# test_unicode
add_executable(test_unicode "projects/test_unicode/test_unicode.cpp")
target_compile_options(test_unicode PRIVATE 
    -fmodules-ts
    -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map
)

# exercise_2_1
add_executable(exercise_2_1 "projects/exercise_2_1/exercise_2_1.cpp")
target_compile_options(exercise_2_1 PRIVATE 
    -fmodules-ts
    -fmodule-mapper=${CMAKE_SOURCE_DIR}/module.map
    -Werror=float-conversion
    -Werror=conversion
)
