import 'package:flutter/material.dart';

import 'base_view_model.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:get/get.dart';

abstract class BaseState<T extends StatefulWidget, V extends BaseViewModel>
    extends State<T> {
  bool onRunning = false;

  @override
  void initState() {
    super.initState();
    getVm().bsRunning.listen((run) {
      setState(() {
        onRunning = run;
      });
    });
  }

  void showLoading() {}

  void closeLoading() {}

  V getVm();
}
