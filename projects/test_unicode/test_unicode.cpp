/*
Personal project file

Copyright (c) 2025 Robert Graf
*/

import std;

int main()
{
    std::locale::global(std::locale(""));
    std::wcout.imbue(std::locale());
    
    char8_t dollar {u8'$'};
    char dollar_char {'$'};
    char16_t delta {u'Δ'};
    wchar_t delta_wide {L'Δ'};
    char32_t ya {U'я'};
    
    std::wcout << L"Delta: " << delta_wide << std::endl;

    return 0;
}
