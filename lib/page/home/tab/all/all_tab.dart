import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/gen/app_colors.dart';
import '/gen/app_strings.dart';
import '/model/task_model.dart';
import '/util/dimens.dart';
import '/util/widget/add_task_button.dart';
import '/util/widget/task_item.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.white,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.w),
              buildDate(),
              StreamBuilder<List<TaskModel>?>(
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
                          data.length - lengthCompleted, lengthCompleted),
                      SizedBox(height: 16.w),
                      line(),
                      SizedBox(height: 16.w),
                      for (int i = 0; i < data.length; i++)
                        TaskItem(
                          data[i],
                          updateTask: getVm().updateTask,
                        )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDate() {
    DateTime date = DateTime.now();
    return Text(
      "${AppStrings.month[date.month]} ${date.day}, ${date.year}",
      style: TextStyle(
        color: AppColors.neutral.dark,
        fontSize: 32.t,
        fontWeight: FontWeight.w700,
      ),
    );
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
      );

  @override
  AllViewModel getVm() => widget.watch.watch(viewModelProvider);
}
