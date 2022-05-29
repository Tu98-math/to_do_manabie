import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/util/widget/action_button.dart';
import '/util/extension/extension.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key, required this.onTap}) : super(key: key);

  final Function(TaskModel) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showAddTaskDialog(context),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.neutral.light,
              AppColors.primary.blue,
            ],
            center: Alignment.bottomRight,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> showAddTaskDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController taskController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          void doneClick() async {
            if (_formKey.currentState!.validate()) {
              await onTap(
                TaskModel(
                    des: taskController.text,
                    completed: false,
                    time: DateTime.now().millisecondsSinceEpoch),
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
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your task"),
                      validator: (val) =>
                          val!.isNotEmpty ? null : "Please enter your task",
                      controller: taskController,
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
}
