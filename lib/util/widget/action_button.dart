import 'package:flutter/material.dart';

import '/gen/app_colors.dart';
import '/util/extension/extension.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(this.text,
      {Key? key, required this.press, this.outline = true})
      : super(key: key);

  final Function press;
  final String text;
  final bool? outline;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: outline! ? Colors.white : AppColors.neutral.dark,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: AppColors.neutral.dark),
      ),
      child: text
          .plain()
          .color(outline! ? AppColors.neutral.dark : Colors.white)
          .fSize(14)
          .weight(FontWeight.w700)
          .b()
          .pad(12.h, 30.w),
    ).inkTap(
      onTap: press,
      borderRadius: BorderRadius.circular(5.r),
    );
  }
}
