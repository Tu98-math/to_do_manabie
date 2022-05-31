import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import '/base/base_state.dart';
import '/gen/app_colors.dart';
import '/gen/app_strings.dart';
import '/gen/assets.gen.dart';
import '/model/task_model.dart';
import '/util/dialog/add_task_dialog.dart';
import '/util/extension/extension.dart';
import '/util/widget/add_task_button.dart';
import '/util/widget/default_tab.dart';
import '/util/widget/task_card.dart';
import '/util/widget/wrong_tab.dart';
import 'all_provider.dart';
import 'all_vm.dart';

class AllTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return AllTab._(watch);
    });
  }

  const AllTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return AllState();
  }
}

class AllState extends BaseState<AllTab, AllViewModel> {
  int countComplete = 0, countIncomplete = 0;

  // ignore: prefer_typing_uninitialized_variables
  late StreamSubscription<List<TaskModel>?> listenCount;

  @override
  void initState() {
    listenCount = getVm().bsTask.listen((value) {
      countComplete = 0;
      countIncomplete = 0;
      for (int i = 0; i < (value ?? []).length; i++) {
        if (value![i].completed ?? true) {
          countComplete++;
        } else {
          countIncomplete++;
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    listenCount.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
      floatingActionButton: (countComplete + countIncomplete) > 0
          ? AddTaskButton(
              onTap: () async =>
                  await showAddTaskDialog(context, getVm().addTask),
            )
          : null,
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      width: screenWidth,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            buildDate().pad(0, 16.w),
            SizedBox(height: 8.h),
            buildStatistic(
              countIncomplete,
              countComplete,
            ).pad(0, 16.w),
            line,
            buildListTask(),
          ],
        ),
      ),
    );
  }

  Widget buildDate() {
    DateTime date = DateTime.now();
    return "${AppStrings.month[date.month]} ${date.day}, ${date.year}"
        .plain()
        .color(AppColors.neutral.dark)
        .fSize(32)
        .weight(FontWeight.w700)
        .b();
  }

  Widget buildStatistic(int incomplete, int completed) {
    return Text(
      "$incomplete incomplete, $completed completed",
      style: TextStyle(
        fontSize: 14.t,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral.grey,
      ),
    );
  }

  Widget line = Container(
    height: 1.w,
    color: AppColors.neutral.light,
  ).pad(16.h, 16.w);

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
                image: Assets.images.noneTask,
                title: "No tasks!",
                buttonText: "Create",
                des: "Tap the button below to create your new task!",
                onTap: () async =>
                    await showAddTaskDialog(context, getVm().addTask),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < data.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: TaskCard(
                      data[i],
                      updateTask: getVm().updateTask,
                      removeTask: getVm().removeTask,
                    ),
                  )
              ],
            );
          },
        ),
      );

  @override
  AllViewModel getVm() => widget.watch(viewModelProvider).state;
}
