.PHONY: run clean test new_devlog_entry help DIRECTORY RULES

new_devlog_entry:
	python3 meta/scripts/new_devlog_entry.py


DIRECTORY?=
RULES?=

run:
	python3 file_sorter/file_sorter.py -d $(DIRECTORY) -r $(RULES)

help:
	python3 file_sorter/file_sorter.py -h

test:
	python3 -m unittest discover -v -s file_sorter/ -t ./file_sorter/

clean:
	rm -rf __pycache__