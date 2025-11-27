/*
Personal project file

Copyright (c) 2025 Robert Graf
*/

import std;

int main()
{
    char char_plain {'A'};
    unsigned char unsigned_char {'A'};
    signed char signed_char {'A'};

    short short_plain {-1};
    unsigned short unsigned_short {1};
    signed short signed_short {-1};

    int int_plain {-1};
    unsigned int unsigned_int {1};
    signed int signed_int {-1};

    long long_plain {-1};
    unsigned long unsigned_long {1};
    signed long signed_long {-1};

    long long long_long_plain {-1};
    unsigned long long unsigned_long_long {1};
    signed long long signed_long_long {-1};

    float float_plain {3.14};
    double double_plain {3.14};
    long double long_double_plain {3.14};
    std::float16_t float16_plain {static_cast<std::float16_t>(3.14)};
    std::float32_t float32_plain {3.14f};
    std::float64_t float64_plain {3.14};
    std::float128_t float128_plain {3.14};

    std::size_t size_type {sizeof(int)};

    std::println("char: plain={}, unsigned={}, signed={}",
                 sizeof(char_plain), sizeof(unsigned_char), sizeof(signed_char));
    std::println("short: plain={}, unsigned={}, signed={}",
                 sizeof(short_plain), sizeof(unsigned_short), sizeof(signed_short));
    std::println("int: plain={}, unsigned={}, signed={}",
                 sizeof(int_plain), sizeof(unsigned_int), sizeof(signed_int));
    std::println("long: plain={}, unsigned={}, signed={}",
                 sizeof(long_plain), sizeof(unsigned_long), sizeof(signed_long));
    std::println("long long: plain={}, unsigned={}, signed={}",
                 sizeof(long_long_plain), sizeof(unsigned_long_long), sizeof(signed_long_long));
    std::println("float: plain={}", sizeof(float_plain));
    std::println("double: plain={}", sizeof(double_plain));
    std::println("long double: plain={}", sizeof(long_double_plain));
    std::println("float16: plain={}", sizeof(float16_plain));
    std::println("float32: plain={}", sizeof(float32_plain));
    std::println("float64: plain={}", sizeof(float64_plain));
    std::println("float128: plain={}", sizeof(float128_plain));
    std::println("size_t: size={}", sizeof(size_type));

    return 0;
}
