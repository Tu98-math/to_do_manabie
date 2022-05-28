import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/util/dimens.dart';
import 'incomplete_provider.dart';
import 'incomplete_vm.dart';

class IncompleteTab extends StatefulWidget {
  final WidgetRef watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return IncompleteTab._(watch);
    });
  }

  const IncompleteTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return IncompleteState();
  }
}

class IncompleteState extends BaseState<IncompleteTab, IncompleteViewModel> {
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
      child: Center(child: Text("Incomplete")),
    );
  }

  @override
  IncompleteViewModel getVm() => widget.watch.watch(viewModelProvider);
}
