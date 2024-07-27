import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/theme/color_schemes.dart';
import 'package:owl/utils/constants/colors.dart';

class CustomInputDecorationTheme {
  CustomInputDecorationTheme._();

  static final lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: CustomColors.lightGrey,
    iconColor: CustomColors.darkGrey,
    suffixIconColor: CustomColors.darkGrey,
    prefixIconColor: CustomColors.darkGrey,
    errorMaxLines: 2,
    border: InputBorder.none,
    hintStyle: TextStyle(color: CustomColors.mediumGrey),
    labelStyle: TextStyle(color: CustomColors.darkGrey, fontSize: 16.sp),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: lightColorScheme.primary,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: lightColorScheme.error,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: lightColorScheme.error,
      ),
    ),
  );

  static final darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: CustomColors.darkGrey,
    iconColor: CustomColors.lightGrey,
    suffixIconColor: CustomColors.lightGrey,
    prefixIconColor: CustomColors.lightGrey,
    errorMaxLines: 2,
    border: InputBorder.none,
    hintStyle: TextStyle(color: CustomColors.mediumGrey),
    labelStyle: TextStyle(color: CustomColors.lightGrey, fontSize: 16.sp),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: darkColorScheme.primary,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: darkColorScheme.error,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: darkColorScheme.error,
      ),
    ),
  );
}
