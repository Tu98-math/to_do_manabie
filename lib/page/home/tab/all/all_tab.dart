import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/gen/app_colors.dart';
import '/gen/app_strings.dart';
import '/model/task_model.dart';
import '/util/extension/extension.dart';
import '/util/widget/add_task_button.dart';
import '/util/widget/task_card.dart';
import 'all_provider.dart';
import 'all_vm.dart';

class AllTab extends StatefulWidget {
  final WidgetRef watch;

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
      floatingActionButton: AddTaskButton(
        onTap: getVm().addTask,
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.w),
            buildDate().pad(0, 16),
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

  Widget line() => Container(
        height: 1.w,
        color: AppColors.neutral.light,
      ).pad(16, 16);

  Widget buildListTask() => StreamBuilder<List<TaskModel>?>(
        stream: getVm().bsTask,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Some thing went Wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          List<TaskModel> data = snapshot.data!;
          int lengthCompleted = 0;
          for (int i = 0; i < data.length; i++) {
            if (data[i].completed ?? true) {
              lengthCompleted++;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.w),
              buildStatistic(
                data.length - lengthCompleted,
                lengthCompleted,
              ).pad(0, 16),
              line(),
              for (int i = 0; i < data.length; i++)
                TaskCard(
                  data[i],
                  updateTask: getVm().updateTask,
                  removeTask: getVm().removeTask,
                )
            ],
          );
        },
      );

  @override
  AllViewModel getVm() => widget.watch.watch(viewModelProvider);
}
