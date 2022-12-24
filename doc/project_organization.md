# File Sorter

## Phase 1 - A.K.A. Mvp

Features:

- Parse a set of rules (Define syntax structure)
- Rules:
  - Delete target
  - Find duplicate Files
  - Find deep duplicate Files

### Defining What is a rule

- [Optional] type of search (flat [only in the given dir] or deep [if we go into other directories and if so how deep])
- *Condition to identify a file/folder
- *[Optional] condition to exclude file/folder
- *Action to execute upon the file/folder

#### Example

- file : type(file) and duplicate(simple) : : delete(this)

## Backlog Features

- UI to set rules
- Rules:
  - Read regex to find files
  - Delete Files
  - Detect how old a file is
  - Addition of rules (x files and x files)
  - Exceptions
- "Downloadable" as a zsh package
- Configurable to run from x time to x time
- Configurable to run at a given time of the day
