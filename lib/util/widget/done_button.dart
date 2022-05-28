import 'package:flutter/material.dart';

import '/gen/app_colors.dart';
import '/util/dimens.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    Key? key,
    required this.onTap,
    this.enable = true,
  }) : super(key: key);

  final Function onTap;

  final bool enable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? () => onTap() : () {},
      child: Container(
        height: 57.w,
        decoration: BoxDecoration(
          color: AppColors.primary.blue.withOpacity(enable ? 1 : .5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: Text(
            "Done",
            style: TextStyle(
              fontSize: 16.t,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
