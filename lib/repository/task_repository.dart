import 'package:to_do_manabie/dao/task_dao.dart';
import 'package:to_do_manabie/model/task_model.dart';

import '/database/database.dart';

class TaskRepository {
  TaskDao? taskDao;

  Future<void> initDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    taskDao = database.taskDao;
  }

  Stream<List<TaskModel>> getAllTask() {
    return taskDao!.getAllTask();
  }

  void removeTask(TaskModel task) {
    taskDao!.deleteTask(task);
  }

  void insertTask(TaskModel task) {
    taskDao!.insertTask(task);
  }
}
