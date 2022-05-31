import '/dao/task_dao.dart';
import '/database/database.dart';
import '/model/task_model.dart';

class TaskRepository {
  late final TaskDao taskDao;

  initDatabase() async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    taskDao = database.taskDao;
  }

  Stream<List<TaskModel>?> getAllTask() {
    return taskDao.getAllTask();
  }

  Stream<List<TaskModel>?> getAllCompletedTask(bool completed) {
    return taskDao.getAllCompletedTask(completed);
  }

  Future<void> removeTask(TaskModel task) async {
    await taskDao.deleteTask(task);
  }

  Future<int> insertTask(TaskModel task) async {
    return await taskDao.insertTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await taskDao.updateTask(task);
  }
}
