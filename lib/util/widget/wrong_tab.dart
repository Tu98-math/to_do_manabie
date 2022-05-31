import 'package:flutter/material.dart';

import '/gen/app_colors.dart';
import '/gen/assets.gen.dart';
import '/util/extension/extension.dart';

class WrongTab extends StatelessWidget {
  const WrongTab(
      {Key? key,
      this.image,
      this.title,
      this.des,
      this.buttonText,
      required this.onTap})
      : super(key: key);

  final AssetGenImage? image;

  final String? title;

  final String? des;

  final String? buttonText;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (image ?? Assets.images.wrong)
            .image(width: screenWidth, fit: BoxFit.fitWidth),
        SizedBox(height: 50.h),
        (title ?? "Oh no!").plain().fSize(24).weight(FontWeight.w700).b(),
        (des ?? "Something went wrong,\nPlease try again.")
            .plain()
            .fSize(15)
            .weight(FontWeight.w400)
            .color(AppColors.neutral.grey)
            .center()
            .b(),
        SizedBox(height: 30.h),
        buildTryAgainButton(),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget buildTryAgainButton() => Container(
        decoration: BoxDecoration(
          //color: AppColors.primary.red,
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.red.withOpacity(.5),
              AppColors.primary.red,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: (buttonText ?? "").plain().b().pad(14.h, 54.w),
      ).inkTap(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
      );
}
