import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/theme/color_schemes.dart';

class CustomOutlinebuttonTheme {
  CustomOutlinebuttonTheme._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      side: BorderSide(
        width: 1.w,
        color: lightColorScheme.primary,
      ),
      textStyle: TextStyle(
        fontFamily: 'Almendra',
        fontSize: 16.sp,
      ),
    ),
  );

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      side: BorderSide(
        width: 1.w,
        color: darkColorScheme.primary,
      ),
      textStyle: TextStyle(
        fontFamily: 'Almendra',
        fontSize: 16.sp,
      ),
    ),
  );
}
