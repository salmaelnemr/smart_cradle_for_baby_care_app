import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors{
  static const Color black = Color(0xFF3C3C3C);
  static const Color white2 = Color(0xFFF3F3F3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFF0F0F0);
  static const Color grey2 = Color(0xFF858585);
  static const Color pink = Color(0xFFB7405A);
  static const Color pinkLight = Color(0xFFF6E6EA);
  static const Color greyLight = Color(0xFFA3A3A3);
  static const Color darkGrey = Color(0xFFD9D9D9);
  static const Color grey3 = Color(0xFFF6E6EA);
  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF30BE71);
  static Color get primaryColor1 => const Color(0xffA02843); //6ca4bc          //  92a5fd
  static Color get primaryColor2 => const Color(0xffFC86A1); //79b9d3         // 9dcdff
  static List<Color> get primaryG => [ primaryColor2, primaryColor1 ];
  static List<Color> get dGray => [ darkGrey, darkGrey];
}