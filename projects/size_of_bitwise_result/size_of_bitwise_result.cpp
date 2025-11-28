/*
Personal project file

Copyright (c) 2025 Robert Graf
*/

import std;

int main()
{
    unsigned char x {1};
    auto y = x & x;
    std::println("Size of bitwise result type: {}", sizeof(y));
    std::println("Type of y is: {}", typeid(y).name());

    unsigned char z {static_cast<unsigned char>(y)};

    unsigned char t {1};
    auto u = t + 1;
    std::println("Size of arithmetic result type: {}", sizeof(u));
    std::println("Type of u is: {}", typeid(u).name());

    unsigned char v {static_cast<unsigned char>(u)};

    return 0;
}
