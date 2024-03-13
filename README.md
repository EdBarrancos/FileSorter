# File Sorter

## Usage

### Make new dev log entry

`make new_devlog_entry` -> It will create a new section on the [development_documention](doc/development_documentation.md) with the current date

### Run tests

`make test`

### Use the program

#### Create Rules

Go to the file [rules](rules.py) and create a class with the filtering and rules you want for your folder

Then, use the command bellow whenever you want to clean it

#### Run program

`make run DIRECTORY=/path/to/directory/to/be/sorted RULES=name_of_class_with_rules`

or

`python3 file_sorter/file_sorter_app.py -d <DIRECTORY> -r <RULES>`

### Setup run command

Clone the repository

#### Zsh

Add to `.zshrc`

```bash
export PATH_TO_FILE_SORTER=/home/user/path/to/file-sorter/repo
run_file_sorter() {
    cwd=$(pwd)
    cd $PATH_TO_FILE_SORTER
    python3 file_sorter/file_sorter_app.py -d /home/user/path/to/dir  -r DeleteDuplicateRule DeleteDebFileRule
    cd $cwd
}
run_file_sorter 1> /dev/null
```

Then you can also, through the use of the command `run_file_sorter` invoke the file_sorter

## Author

Yours trully, Eduardo Barrancos
