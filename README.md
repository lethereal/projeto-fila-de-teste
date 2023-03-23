# projeto-fila-de-teste
Video Testing Queue Project

This is a personal project that aims to make tracking video testing data easier and more practical for in-house broadcast VT operators, with me being one of them, as well as acquiring practical experience with software development.
The goal is to build an application capable of autonomously importing our current Excel sheet's data exported as CSV and make it easier and  pratical to register tests for upcoming videos.

Milestones:

1) Implement a Bash importing script that reads the original CSV file with previous test data and insert it into a hosted PostgreSQL database. 
- CLIP1 import complete, bugs fixed.
- CLIP2 import complete, bugs fixed.
- INFOWS import complete, bugs fixed.

STEP 1 COMPLETE

Technology used in this step:
- Shell
- Bash
- PostgreSQL
- Git
- GitHub

2) Create a terminal application capable of visualizing said data.

3) Update the program as to make it possible to create new entries.
  3.1) Add the possibility of automatically filling some of the fields using file metadata.

3) Create a GUI application using the logical structure of the terminal application.
