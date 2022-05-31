import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/gen/app_colors.dart';
import '/gen/app_strings.dart';
import '/model/task_model.dart';
import '/util/dialog/delete_task_dialog.dart';
import '/util/dialog/edit_task_dialog.dart';
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

  final Future<void> Function(TaskModel) removeTask;

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
                  await showEditTaskDialog(
                    context,
                    task,
                    updateTask,
                  );
                  controller.activeState?.close();
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
            await showDeleteTaskDialog(context, removeTask, task);
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
}
