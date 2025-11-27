/*
Personal project file

Copyright (c) 2025 Robert Graf
*/

import std;

int main()
{
    int x {3};
    x = ++x + x++ + x;
    std::println("Final value of x is {}", x); // x is 13
    return 0;
}
