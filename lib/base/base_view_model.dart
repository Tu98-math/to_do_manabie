import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/gen/app_colors.dart';
import '/repository/task_repository.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:rxdart/rxdart.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseViewModel {
  BehaviorSubject<bool> bsRunning = BehaviorSubject.seeded(false);

  final AutoDisposeStateProviderRef ref;

  TaskRepository getTask = TaskRepository();

  BaseViewModel(this.ref);

  @mustCallSuper
  void dispose() {
    bsRunning.close();
  }

  showToast({String text = 'A task is in progress, please wait'}) async {
    await Fluttertoast.showToast(
      msg: text,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.neutral.dark,
      textColor: AppColors.background,
    );
  }

  startRunning() => bsRunning.add(true);

  endRunning() => bsRunning.add(false);
}
