import 'package:floor/floor.dart';

import '/model/task_model.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM TaskModel')
  Stream<List<TaskModel>?> getAllTask();

  @Query('SELECT * FROM TaskModel WHERE completed = :completed')
  Stream<List<TaskModel>?> getAllCompletedTask(bool completed);

  @insert
  Future<void> insertTask(TaskModel task);

  @update
  Future<void> updateTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);
}
