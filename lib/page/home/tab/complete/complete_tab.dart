import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import '/util/extension/extension.dart';

import '/gen/assets.gen.dart';
import '/model/task_model.dart';
import '/util/widget/default_tab.dart';
import '/util/widget/task_card.dart';
import '/util/widget/wrong_tab.dart';
import '/base/base_state.dart';
import 'complete_provider.dart';
import 'complete_vm.dart';

class CompleteTab extends StatefulWidget {
  final ScopedReader watch;

  final Function tabClick;

  static Widget instance(Function tabClick) {
    return Consumer(builder: (context, watch, _) {
      return CompleteTab._(watch, tabClick);
    });
  }

  const CompleteTab._(this.watch, this.tabClick);

  @override
  State<StatefulWidget> createState() {
    return CompleteState();
  }
}

class CompleteState extends BaseState<CompleteTab, CompleteViewModel> {
  int countComplete = 0;

  @override
  void initState() {
    super.initState();
    getVm().bsTask.listen((value) {
      countComplete = (value ?? []).length;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: countComplete > 0 ? buildAppBar() : null,
      backgroundColor: countComplete > 0 ? Colors.white : Color(0xFFE7EFFC),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() =>
      "Incomplete".plainAppBar().centerTitle(true).bAppBar();

  Widget buildBody() {
    return SizedBox(
      width: screenWidth,
      child: buildListTask(),
    );
  }

  Widget buildListTask() => SizedBox(
        width: screenWidth,
        child: StreamBuilder<List<TaskModel>?>(
          stream: getVm().bsTask,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return WrongTab(
                image: Assets.images.wrong,
                title: "Oh no!",
                des: "Something went wrong, Please try again.",
                onTap: () async => await Restart.restartApp(),
                buttonText: "Try Again",
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const DefaultTab();
            }

            List<TaskModel> data = snapshot.data!;

            if (data.isEmpty) {
              return WrongTab(
                image: Assets.images.noneDone,
                title: "No task completed",
                buttonText: "Let go",
                des: "Tap the button below to plan your next task!",
                onTap: widget.tabClick,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.w),
                for (int i = 0; i < data.length; i++)
                  TaskCard(
                    data[i],
                    updateTask: getVm().updateTask,
                    removeTask: getVm().removeTask,
                  )
              ],
            );
          },
        ),
      );

  @override
  CompleteViewModel getVm() => widget.watch(viewModelProvider).state;
}
