import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/util/widget/action_button.dart';
import '/util/extension/extension.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key, required this.onTap}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    ).inkTap(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
    );
  }
}
