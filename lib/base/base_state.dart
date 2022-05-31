import 'dart:async';

import 'package:flutter/material.dart';

import 'base_view_model.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:get/get.dart';

abstract class BaseState<T extends StatefulWidget, V extends BaseViewModel>
    extends State<T> {
  bool onRunning = false;

  late StreamSubscription<bool> streamRunning;

  @override
  void initState() {
    super.initState();
    streamRunning = getVm().bsRunning.listen((run) {
      setState(() {
        onRunning = run;
      });
    });
  }

  @override
  void dispose() {
    streamRunning.cancel();
    super.dispose();
  }

  void showLoading() {}

  void closeLoading() {}

  V getVm();
}
