osric-character-sheet-to-json
=============================

A simple Perl script to read in a human-typed OSRIC character sheet, and export the character info to JSON so the lovely [obot](https://github.com/dami0/obot) can read it.

Usage
-----

Usage is simple enough. Just pass the path to the character sheet(s) and it'll give you a JSON .sheet file for each:

```
chmod +x character-sheet.pl
./character-sheet.pl /path/to/sheet1 /path/to/sheet2
```

Example character sheet
-----------------------

```
--- PERSONAL ---
Name: kirby
Class: Magic User
Alignment: Chaotic Good
Race: Human
XP: 2
HP: 2
AC: 2
Lvl: 2
Age: 2
Height: 2
Weight: 2
Sex: M

--- ABILITIES ---
Str: 2
Dex: 2
Con: 2
Int: 2
Wis: 2
Cha: 2

--- WEALTH ---
Gold: 40
```

The script is a lot more leniant, and so you don't need things like capitalization or whitespace or the colon or the headers, but doing so keeps it human-readable :)
