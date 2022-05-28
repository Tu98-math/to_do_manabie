import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/util/dimens.dart';
import 'complete_provider.dart';
import 'complete_vm.dart';

class CompleteTab extends StatefulWidget {
  final WidgetRef watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return CompleteTab._(watch);
    });
  }

  const CompleteTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return CompleteState();
  }
}

class CompleteState extends BaseState<CompleteTab, CompleteViewModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      width: screenWidth,
      child: Center(child: Text("Complete")),
    );
  }

  @override
  CompleteViewModel getVm() => widget.watch.watch(viewModelProvider);
}
