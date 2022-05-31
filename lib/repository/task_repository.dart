import 'package:to_do_manabie/dao/task_dao.dart';
import 'package:to_do_manabie/model/task_model.dart';

import '/database/database.dart';

class TaskRepository {
  static TaskDao? taskDao;

  Future<void> initDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    taskDao = database.taskDao;
  }

  Stream<List<TaskModel>?> getAllTask() {
    return taskDao!.getAllTask();
  }

  Stream<List<TaskModel>?> getAllCompletedTask(bool completed) {
    return taskDao!.getAllCompletedTask(completed);
  }

  Future<void> removeTask(TaskModel task) async {
    await taskDao!.deleteTask(task);
  }

  Future<void> insertTask(TaskModel task) async {
    await taskDao!.insertTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await taskDao!.updateTask(task);
  }
}
