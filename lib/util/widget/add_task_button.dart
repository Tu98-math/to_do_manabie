import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';
import '/util/dimens.dart';
import '/util/widget/done_button.dart';

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
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showAddTaskDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController taskController = TextEditingController();

    bool onRunning = false;

    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          void startRun() {
            setState(() {
              onRunning = true;
            });
          }

          void endRun() {
            setState(() {
              onRunning = false;
            });
          }

          void doneClick() async {
            startRun();
            if (_formKey.currentState!.validate()) {
              await Future.delayed(const Duration(seconds: 1));
              await onTap(
                TaskModel(
                    des: taskController.text,
                    completed: false,
                    time: DateTime.now().millisecondsSinceEpoch),
              );
              Get.back();
            }
            endRun();
          }

          return AlertDialog(
            contentPadding: EdgeInsets.all(16.w),
            titlePadding: EdgeInsets.all(16.w),
            title: Text(
              "Add Task",
              style: TextStyle(
                fontSize: 18.t,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    SizedBox(height: 20.w),
                    DoneButton(
                      onTap: doneClick,
                      enable: !onRunning,
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
