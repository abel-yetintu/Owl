import 'package:flutter/material.dart';
import 'package:owl/theme/color_schemes.dart';
import 'package:owl/theme/custom_themes/app_bar_theme.dart';
import 'package:owl/theme/custom_themes/filled_button_theme.dart';
import 'package:owl/theme/custom_themes/input_decoration_theme.dart';
import 'package:owl/theme/custom_themes/outline_button_theme.dart';
import 'package:owl/theme/custom_themes/text_theme.dart';
import 'package:owl/utils/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: CustomColors.lightBackgroundColor,
    textTheme: CustomTextTheme.lightTextTheme,
    inputDecorationTheme: CustomInputDecorationTheme.lightInputDecorationTheme,
    filledButtonTheme: CustomFilledButtonTheme.lightFilledButtonTheme,
    outlinedButtonTheme: CustomOutlinebuttonTheme.lightOutlineButtonTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: CustomColors.darkBackgroundColor,
    textTheme: CustomTextTheme.darkTextTheme,
    inputDecorationTheme: CustomInputDecorationTheme.darkInputDecorationTheme,
    filledButtonTheme: CustomFilledButtonTheme.darkFilledButtonTheme,
    outlinedButtonTheme: CustomOutlinebuttonTheme.darkOutlineButtonTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
  );
}
