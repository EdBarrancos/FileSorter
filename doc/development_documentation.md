# File Sorter

## Final Goal

Have a program that receives a directory and can access to a set of rules it will use to sort the dir

I want the rules to have some sort of syntax

I also want to try to learn a new programming language, I have chosen ~~Rust~~ Python. I'm not actually new to Python, but I wanted to try out functional prgramming and doing that whilst learning a new language seemed a little bit overwhelming

I would also like it to be downloadable as a "zsh_package"? Not sure if that is a thing, but we will see

## Development Logs

### 18/11/22

- Created this file and defined the first goals
- Set up "Hello World"

### 20/11/22

- Switch from Rust to Python
- Setup Python
- [Project Structure](https://docs.python-guide.org/writing/structure/)

#### Immediate Goals

- [x] Create a argument parser (Console Arguments)
- [x] Create a test for this
- [x] Use and read about Logging
- [x] Make a scrpit to create this dev logs

#### Questions

- **Should I create a virtual env?**
  - *Insert Answer here*

#### Useful info

- [Testing](https://docs.python-guide.org/writing/tests/)

### 21/11/22

- New Dev Log entry script
- Created a make file and rule for entrying a new dev log
- Create configs
- Created a log creation file

#### Questions - 21/11/22

- **Is this the correct way of implementing functional programming and using configurations?**
  - If I end up having modules inside modules inside modules, all of them need to keep accessing the configs so they can create a logger. Which means the configuration object will have to go DEEP. Maybe that isnt so bad. We will see...
  - I can also try to create the get_logger as a decorator? not sure if that would work, have to read up on decorators a bit more
  - *Insert Answer here or leave it like this :p*

#### Useful info - 21/11/22

- [Logging](https://www.toptal.com/python/in-depth-python-logging)
- [Good Practices](https://www.toptal.com/python/top-10-mistakes-that-python-programmers-make)

### 22/11/22

- Remove configs from repo and made sure gitignore was working
- Fix logging
- Starting to organize my project with testing in mind
- Update Configs so that we store it statically
- Refactor Logging so that we create the loggers when logging for the first time

#### Useful info - 22/11/22

- [More testing](https://realpython.com/python-testing/#executing-your-first-test)

### 24/11/22

- Created Automated testing on github using actions
- Expand logging tests
- Rename main
- Decorators
- Command line argument parsing
- New Makefile rule to clean pychache related stuff
- Decorator tests

#### Immediate Goals - 24/11/22 - NOT_COMPLETED

- [ ] Checkout what else can I do with github actions
- [ ] New entry script scan for non filled sections from the last log and delete them
- [ ] From time to time review the code and if im abidying by the functional programming paradigm
- [x] Command line parsing tests

#### Questions - 24/11/22

- **Should I still create branches and pull requests even while working alone?**
  - Arguments for no:
    - Too much work
  - Arguments for yes:
    - Provides Isolation
    - Can run automatic tests
    - More easily reversible
  - *Oki, Ill do it*

#### Useful info - 24/11/22

- [Style Guid](https://peps.python.org/pep-0008/)

### 25/11/22

- Started CommandLine Argument Parsing Tests
- Protected Main Branch
- Added some usage stuff to the README

#### Immediate Goals - 25/11/22 - NOT_COMPLETED

- [ ] Investigate more about branch protection
- [ ] Make a script that takes this "TODO"s and writes them to an isolated file, easier to see (backlog)

### 29/11/22

- Decorator to test arguments for None only
- parse arguments recursive
- Finish Tests to Parsing Arguments

#### Immediate Goals - 29/11/22 - NOT_COMPLETED

- [ ] Test for new decorator function
- [ ] New Entry check first if there is already an entry with that date
- [ ] I feel like the \_\_eq\_\_ is not very functional programmy. Try to find a elegant solution which is still functional programmy
- [x] Make Parse Command Line Arguments recursive
- [x] Add title to parameterized tests
- [ ] Script to go through the goals and create an organized document

### 30/11/22

- Added title to tests

### 01/12/22

- *Insert what you did today here*

#### Immediate Goals - 01/12/22

- [x] Improve makefile (clean)

### 18/12/22

- Use argparser module
- Improve makefile
- Finish argument Parsing

#### Immediate Goals - 18/12/22

- [ ] *Insert future goals/problems to solve here*

#### Questions - 18/12/22 - NOT_COMPLETED

- **Insert your questions here**
  - *Insert Answer here or leave it like this :p*

#### Useful info - 18/12/22

- [*What is the info about*](*https://...)
