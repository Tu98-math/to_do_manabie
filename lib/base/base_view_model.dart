import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/repository/task_repository.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:rxdart/rxdart.dart';

abstract class BaseViewModel {
  BehaviorSubject<bool> bsRunning = BehaviorSubject.seeded(false);

  final AutoDisposeStateProviderRef ref;

  TaskRepository getTask = TaskRepository();

  BaseViewModel(this.ref);

  @mustCallSuper
  void dispose() {
    bsRunning.close();
  }

  startRunning() => bsRunning.add(true);

  endRunning() => bsRunning.add(false);
}
