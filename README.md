# This is a recruitment test of Manabie.

![Alt text](https://github.com/Tu98-math/to_do_manabie/blob/main/logo_manabie.png)

## Requirement:

Writing a TODO application include 3 screens:
- [x] All: Showing both complete and incomplete Todo.
- [x] Complete: Showing complete Todo.
- [x] Incomplete: Show incomplete Todo.
- [x] Having a Bottom navigation bar to switch between the above 

## Business logic:

- [x] Having an “Create task” UI to create a new Todo.
- [x] Each Todo has a checkbox, to change its status between complete and incomplete.
- [x] When interacting (Create task or Change task’s status), the UI (Todo list, checkbox) must be updated.
- [x] Must handle and show UI in the error cases when creating tasks andupdating task status.
- [x] If you can handle saving and updating Todo tasks in the local database, it will be a plus (**SQLite**).

## Technical:

- [x] MUST HAVE unit tests. Automation testing is our culture. We would mark the assignment as failed if you don’t submit the assignment with meaningful unit tests.
  - [ ] Having widget tests and integration tests is a plus.
- [x] You can use any architecture you want, but the architecture must describe 3 layers: Presentation layer, Domain (Business) layer and Data Access layer. (**MVVM**)
- [x] Providing a concise and instructional README on how to run the code and unit test cases.
- [x] Use appropriate data structures.
- [x] The assignment can be implemented with either **Dart (Flutter)** or a native iOS/Android language.

## Run:

- Flutter SDK version: **2.10.5**
- Platform: Android & iOS
- Run my app: 
  - Clone git:         
    $ git clone https://github.com/Tu98-math/to_do_manabie.git
  - Go to project:     
    $ cd to_do_manabie 
  - Get dependencies: 
    $ flutter pub get
  - Connect device and run app
- Run unit test:
  - Task validate: 
    $ flutter test test\task_validate_test.dart
  - Task repository: 
    $ flutter test test\task_repository_test.dart


## To Do App Final UI
