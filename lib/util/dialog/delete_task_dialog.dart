import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/gen/app_colors.dart';
import '/model/task_model.dart';
import '/util/extension/extension.dart';
import '/util/widget/action_button.dart';

Future<void> showDeleteTaskDialog(
  BuildContext context,
  Future<void> Function(TaskModel) press,
  TaskModel task,
) async {
  Widget cancelButton = ActionButton('Cancel', press: () {
    Get.back();
  });

  Widget yesButton = ActionButton(
    'Yes, I\'m sure',
    press: () async {
      press(task);
      Get.back();
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
