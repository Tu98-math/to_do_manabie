import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import '/base/base_state.dart';
import '/gen/app_colors.dart';
import '/gen/assets.gen.dart';
import '/model/task_model.dart';
import '/util/dialog/add_task_dialog.dart';
import '/util/dimens.dart';
import '/util/extension/widget_extension.dart';
import '/util/widget/default_tab.dart';
import '/util/widget/task_card.dart';
import '/util/widget/wrong_tab.dart';
import 'incomplete_provider.dart';
import 'incomplete_vm.dart';

class IncompleteTab extends StatefulWidget {
  final ScopedReader watch;

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
  int countIncomplete = 0;

  late StreamSubscription<List<TaskModel>?> streamCount;

  @override
  void initState() {
    super.initState();
    streamCount = getVm().bsTask.listen((value) {
      countIncomplete = (value ?? []).length;
      setState(() {});
    });
  }

  @override
  void dispose() {
    streamCount.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildBody(),
    );
  }

  Widget buildBody() {
    return Scaffold(
      appBar: countIncomplete > 0 ? buildAppBar() : null,
      backgroundColor:
          countIncomplete > 0 ? Colors.white : AppColors.background,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(child: buildListTask()),
      ),
    );
  }

  AppBar buildAppBar() =>
      "Incomplete".plainAppBar().centerTitle(true).bAppBar();

  Widget buildListTask() => SizedBox(
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
                image: Assets.images.allDone,
                title: "All Done!",
                buttonText: "Add New",
                des: "All tasks completed!\ntime to take some rest!",
                onTap: () async =>
                    await showAddTaskDialog(context, getVm().addTask),
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
  IncompleteViewModel getVm() => widget.watch(viewModelProvider).state;
}
