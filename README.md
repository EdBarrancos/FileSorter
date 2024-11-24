# File Sorter

## Usage


### Use the program

#### Create new Rules

Modify the files [CustomAnalyzers](src/customRules/CustomAnalyzers.jl), [CustomQueueItems](src/customRules/CustomQueueItems.jl) and [CustomRules](src/customRules/CustomRules.jl)

`Analyzers` are what look to files and directories, retrieve and register information about them. For example, their type, how many files inside a directory, ... For files they run once, for directories they analyze twice, one before and another after we look into the directory's content.

`QueueItems` are actions to perform to files and directories. For example, delete them, move them, rename them. They are processed at the end of everything.

`Rules` group the two above. They register the needed analyzers, then look into the registered info and queue or not items.

#### Run program

`juliaa /path/to/src/FileSorter.jl /path/to/folder/to/sort <RULES>`

##### Rules Syntax

`<rule1> <arg1> <arg2>, <rule2> ...`

### Setup Example

Clone the repository

#### Zsh

Add to `.zshrc`

```bash
export PATH_TO_FILE_SORTER=/path/to/FileSorter
export PATH_TO_FILE_TO_SORT=/path/to/sort
run_file_sorter() {
    julia $PATH_TO_FILE_SORTER/src/FileSorter.jl $PATH_TO_FILE_TO_SORT DeleteFilesByType deb zip, DeleteFilesByTypeCreatedSinceDays snap mp4 png jpg webp gz jpeg 240, DeleteFilesByTypeCreatedSinceDays pdf 365
}
run_file_sorter
```

Then you can also, through the use of the command `run_file_sorter` invoke the file_sorter

## Author

Yours trully, Eduardo Barrancos
