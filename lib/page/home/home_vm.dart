import 'dart:async';

import '/base/base_view_model.dart';
import '/model/task_model.dart';

class HomeViewModel extends BaseViewModel {
  BehaviorSubject<List<TaskModel>?> bsTask =
      BehaviorSubject<List<TaskModel>?>();

  BehaviorSubject<bool> bsLoading = BehaviorSubject.seeded(true);

  HomeViewModel(ref) : super(ref) {
    init();
  }

  late StreamSubscription<List<TaskModel>?> streamTask;

  @override
  void dispose() {
    streamTask.cancel();
    super.dispose();
  }

  init() async {
    await taskRes.initDatabase();
    bsLoading.add(false);
    streamTask = taskRes.getAllTask().listen((event) {
      bsTask.add(event);
    });
  }
}
