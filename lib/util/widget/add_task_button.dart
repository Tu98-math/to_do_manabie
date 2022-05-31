import 'package:flutter/material.dart';

import '/gen/app_colors.dart';
import '/util/extension/extension.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key, required this.onTap}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.h,
      height: 56.h,
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
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.h,
      ),
    ).inkTap(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
    );
  }
}
