# File Sorter

## Author

Yours trully, Eduardo Barrancos

## Usage - 06/03/24

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

`python3 file_sorter/file_sorter.py -d <DIRECTORY> -r <RULES>`
