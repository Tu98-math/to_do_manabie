import 'package:floor/floor.dart';
import 'package:to_do_manabie/model/task_model.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM TaskModel')
  Stream<List<TaskModel>> getAllTask();

  @insert
  Future<void> insertTask(TaskModel task);

  @update
  Future<void> updateTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);
}
