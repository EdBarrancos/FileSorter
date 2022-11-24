new_devlog_entry:
	python3 meta/scripts/new_devlog_entry.py

run:
	python3 file_sorter/file_sorter.py

test:
	python3 -m unittest discover -v -s file_sorter/ -t ./file_sorter/