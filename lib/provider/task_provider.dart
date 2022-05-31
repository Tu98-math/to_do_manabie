import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/repository/task_repository.dart';
import '/database/database.dart';

final taskDaoRepositoryProvider = Provider((ref) {
  return TaskRepository();
});
