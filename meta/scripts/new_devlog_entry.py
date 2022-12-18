from datetime import date

PATH_TO_DEVELOPMENT_LOGS = "doc/development_documentation.md"

NEW_ENTRY = """
### {date}

- *Insert what you did today here*

#### Immediate Goals - {date}

- [ ] *Insert future goals/problems to solve here*

#### Questions - {date} - NOT_COMPLETED

- **Insert your questions here**
  - *Insert Answer here or leave it like this :p*

#### Useful info - {date}

- [*What is the info about*](*https://...)
""".format(date=date.today().strftime("%d/%m/%y"))

with open(PATH_TO_DEVELOPMENT_LOGS, 'a') as dev_logs_file:
    dev_logs_file.write(NEW_ENTRY)
