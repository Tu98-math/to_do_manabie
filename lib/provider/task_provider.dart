import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/repository/task_repository.dart';

final taskDaoRepositoryProvider = Provider((ref) {
  return TaskRepository();
});
