import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:to_do_manabie/dao/task_dao.dart';
import 'package:to_do_manabie/model/task_model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [TaskModel])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
