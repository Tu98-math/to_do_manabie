import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';
import '/util/extension/extension.dart';
import '/util/validator/task_field_validator.dart';
import '/util/widget/action_button.dart';

Future<void> showAddTaskDialog(
    BuildContext context, Function(TaskModel) addTask) async {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        void doneClick() async {
          if (_formKey.currentState!.validate()) {
            await addTask(
              TaskModel(
                des: controller.text.trim(),
                completed: false,
                time: DateTime.now().millisecondsSinceEpoch,
              ),
            );
            Get.back();
          }
        }

        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          titlePadding: EdgeInsets.all(16.w),
          title: "Create Task"
              .plain()
              .fSize(20)
              .weight(FontWeight.w700)
              .color(AppColors.neutral.dark)
              .b(),
          actionsPadding: EdgeInsets.only(bottom: 12.w, right: 12.w),
          actions: [
            ActionButton(
              'Done',
              press: doneClick,
              outline: false,
            ),
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
                    style: TextStyle(fontSize: 14.w),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your task",
                    ),
                    validator: TaskFieldValidator.validate,
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
