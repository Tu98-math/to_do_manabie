import 'dart:math';

import 'package:flutter/material.dart';
import '/util/extension/extension.dart';

import '/util/place_holder/default_shimmer.dart';

class DefaultTab extends StatelessWidget {
  const DefaultTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int randomShimmer = Random().nextInt(5) + 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < randomShimmer; i++)
          RectangleShimmer(
            width: 343.w,
            height: 70.w,
            borderRadius: BorderRadius.circular(5.r),
          ).pad(8, 16)
      ],
    );
  }
}
