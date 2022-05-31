import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:to_do_manabie/util/widget/action_button.dart';

import '/gen/app_colors.dart';
import '/gen/app_strings.dart';
import '/model/task_model.dart';
import '/util/extension/extension.dart';

part 'task_card.description.dart';
part 'task_card.icon_checked.dart';
part 'task_card.slidable_icon.dart';

class TaskCard extends StatelessWidget {
  TaskCard(
    this.task, {
    Key? key,
    required this.updateTask,
    required this.removeTask,
  }) : super(key: key);

  final TaskModel task;

  final Function(TaskModel) updateTask;

  final Function(TaskModel) removeTask;

  final SlidableController controller = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(task.id!.toString()),
      controller: controller,
      actionPane: const SlidableDrawerActionPane(),
      dismissal: const SlidableDismissal(
        dragDismissible: false,
        child: SlidableDrawerDismissal(),
      ),
      secondaryActions: [
        Row(
          children: [
            Expanded(
              child: SlidableIcon(
                Icons.edit,
                press: () async {
                  await showEditTaskDialog(context);
                },
              ),
            ),
            Container(
              width: 1,
              color: AppColors.neutral.grey,
            )
          ],
        ),
        SlidableIcon(
          Icons.delete,
          press: () async {
            await showDeleteTaskDialog(context);
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral.light,
              offset: const Offset(5, 5),
              blurRadius: 9,
            )
          ],
        ),
        child: Row(
          children: [
            buildIconChecked(task.completed ?? true),
            Expanded(
              child: buildDescription(),
            ),
            buildLine(task.completed ?? true),
          ],
        ),
      ),
    ).pad(8, 16);
  }

  Widget buildIconChecked(bool checked) {
    return IconChecked(
      checked,
      press: () => updateTask(
        TaskModel(
          id: task.id,
          des: task.des,
          completed: !task.completed!,
          time: task.time,
        ),
      ),
    );
  }

  Widget buildDescription() => Description(task);

  Widget buildLine(bool checked) => Container(
        width: 4.w,
        height: 21.w,
        color: checked ? AppColors.primary.red : AppColors.primary.blue,
      ).pad(10, 0, 0);

  showDeleteTaskDialog(BuildContext context) {
    Widget cancelButton = ActionButton('Cancel', press: () {
      Get.back();
    });

    Widget yesButton = ActionButton(
      'Yes, I\'m sure',
      press: () async {
        Get.back();
        controller.activeState!.dismiss();
        removeTask(task);
      },
      outline: false,
    );

    AlertDialog alert = AlertDialog(
      title: 'Are you sure?'
          .plain()
          .fSize(20)
          .weight(FontWeight.w700)
          .color(AppColors.neutral.dark)
          .b(),
      content: RichText(
        text: TextSpan(
            style: TextStyle(color: AppColors.neutral.grey, fontSize: 14.t),
            children: <TextSpan>[
              const TextSpan(text: 'All your changes will be '),
              TextSpan(
                text: 'deleted',
                style: TextStyle(color: AppColors.primary.red),
              ),
              const TextSpan(
                text: ' and you will no longer be able to access them.',
              )
            ]),
      ),
      actionsPadding: EdgeInsets.only(bottom: 12.w, right: 12.w),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> showEditTaskDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController taskController = TextEditingController();
    taskController.text = task.des ?? '';

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
              await updateTask(
                TaskModel(
                  id: task.id,
                  des: taskController.text,
                  completed: false,
                  time: DateTime.now().millisecondsSinceEpoch,
                ),
              );
              Get.back();
              controller.activeState!.close();
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
