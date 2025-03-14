import 'package:flutter/material.dart';
import 'app_colors/app_colors.dart';

class Utils {
  static String getPNGAssetPath(String value){
    return 'assets/images/$value.png';
  }

  static ThemeData get appTheme {
    return ThemeData(
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
        color: AppColors.black,
        elevation: 0.0,
      ),
      canvasColor: AppColors.black,
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkGrey,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.pinkLight),
        ),
      ),
    );
  }

  static const List<Color> noteColors = [
    Colors.grey,
    Colors.green,
    Colors.purple,
    Colors.yellow,
    Colors.blue,
    Colors.amber,
    Colors.teal,
    Colors.blueGrey,
    Colors.brown,
  ];
}