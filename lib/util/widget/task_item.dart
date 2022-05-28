import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_manabie/util/dimens.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {Key? key, required this.updateTask})
      : super(key: key);

  final TaskModel task;

  final Function(TaskModel) updateTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => updateTask(
              TaskModel(
                id: task.id,
                des: task.des,
                completed: !task.completed!,
                time: task.time,
              ),
            ),
            child: Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.neutral.light,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: (task.completed ?? true)
                  ? Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.neutral.grey,
                        size: 20.w,
                      ),
                    )
                  : null,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              task.des ?? "",
              style: TextStyle(
                color: (task.completed ?? true)
                    ? AppColors.neutral.grey
                    : AppColors.neutral.dark,
                fontSize: 18.t,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
