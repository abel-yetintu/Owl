import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/utils/constants/colors.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static final lightTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Almendra',
      fontSize: 18.sp,
      color: CustomColors.darkGrey,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Almendra',
      fontSize: 16.sp,
      color: CustomColors.darkGrey,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Almendra',
      fontSize: 12.sp,
      color: CustomColors.darkGrey,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Almendra',
      fontWeight: FontWeight.w700,
      color: CustomColors.darkGrey,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.darkGrey,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.darkGrey,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.darkGrey,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.darkGrey,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.darkGrey,
    ),
  );

  static final darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Almendra',
      fontSize: 18.sp,
      color: CustomColors.lightGrey,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Almendra',
      fontSize: 16.sp,
      color: CustomColors.lightGrey,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Almendra',
      fontSize: 12.sp,
      color: CustomColors.lightGrey,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Almendra',
      fontWeight: FontWeight.w700,
      color: CustomColors.lightGrey,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.lightGrey,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.lightGrey,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.lightGrey,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.lightGrey,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Almendra',
      color: CustomColors.lightGrey,
    ),
  );
}
