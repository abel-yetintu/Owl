import 'package:flutter/material.dart';
import 'package:owl/utils/constants/colors.dart';

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: CustomColors.primaryColor,
  onPrimary: CustomColors.lightGrey,
  secondary: CustomColors.secondaryColor,
  onSecondary: CustomColors.darkGrey,
  tertiary: CustomColors.tertiaryColor,
  onTertiary: CustomColors.lightGrey,
  error: Colors.red,
  onError: Colors.white,
  surface: CustomColors.primaryColor,
  onSurface: CustomColors.lightGrey,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: CustomColors.darkPrimaryColor,
  onPrimary: CustomColors.lightGrey,
  secondary: CustomColors.darkSecondaryColor,
  onSecondary: CustomColors.darkGrey,
  tertiary: CustomColors.darkTertiaryColor,
  onTertiary: CustomColors.lightGrey,
  error: Colors.red,
  onError: Colors.white,
  surface: CustomColors.darkPrimaryColor,
  onSurface: CustomColors.lightGrey,
);
