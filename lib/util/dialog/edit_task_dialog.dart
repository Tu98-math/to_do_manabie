import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';
import '/util/extension/extension.dart';

Future<void> showEditTaskDialog(
    BuildContext context, TaskModel task, Function(TaskModel) press) async {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  controller.text = task.des ?? '';

  Widget doneButton = Container(
    decoration: BoxDecoration(
      color: AppColors.neutral.dark,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.neutral.dark),
    ),
    child: 'Done'
        .plain()
        .color(Colors.white)
        .fSize(12)
        .weight(FontWeight.w700)
        .b()
        .pad(8, 30),
  );

  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        void doneClick() async {
          if (_formKey.currentState!.validate()) {
            press(
              TaskModel(
                id: task.id,
                des: controller.text,
                completed: false,
                time: task.time,
              ),
            );
            Get.back();
          }
        }

        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          titlePadding: EdgeInsets.all(16.w),
          title: "Edit Task"
              .plain()
              .fSize(20)
              .weight(FontWeight.w700)
              .color(AppColors.neutral.dark)
              .b(),
          actionsPadding: EdgeInsets.only(bottom: 12.w, right: 12.w),
          actions: [
            doneButton.inkTap(onTap: doneClick),
          ],
          content: SizedBox(
            width: screenWidth,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your task",
                    ),
                    validator: (val) =>
                        val!.isNotEmpty ? null : "Please enter your task",
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
