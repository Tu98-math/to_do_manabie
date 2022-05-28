import 'package:flutter/material.dart';

class AppColors {
  static const $AssetsPrimaryColor primary = $AssetsPrimaryColor();

  static const $AssetsNeutralColor neutral = $AssetsNeutralColor();

  static const Color background = Color(0xFFFFFFFF);
}

class $AssetsPrimaryColor {
  const $AssetsPrimaryColor();

  Color get blue => const Color(0xFF40BFFF);

  Color get red => const Color(0xFFFB7181);

  Color get yellow => const Color(0xFFFFC833);

  Color get green => const Color(0xFF53D1B6);

  Color get purple => const Color(0xFF5C61F4);
}

class $AssetsNeutralColor {
  const $AssetsNeutralColor();

  Color get dark => const Color(0xFF223263);

  Color get grey => const Color(0xFF9098B1);

  Color get light => const Color(0xFFEBF0FF);
}
