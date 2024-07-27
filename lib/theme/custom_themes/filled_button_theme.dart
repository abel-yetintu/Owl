import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/theme/color_schemes.dart';
import 'package:owl/utils/constants/colors.dart';

class CustomFilledButtonTheme {
  CustomFilledButtonTheme._();

  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      textStyle: TextStyle(
        fontFamily: 'Almendra',
        fontSize: 16.sp,
      ),
      backgroundColor: lightColorScheme.primary,
      disabledBackgroundColor: lightColorScheme.primary.withOpacity(.8),
      disabledForegroundColor: CustomColors.tertiaryColor,
    ),
  );
  static final darkFilledButtonTheme = FilledButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      textStyle: TextStyle(
        fontFamily: 'Almendra',
        fontSize: 16.sp,
      ),
      backgroundColor: darkColorScheme.primary,
      disabledBackgroundColor: darkColorScheme.primary.withOpacity(.8),
      disabledForegroundColor: CustomColors.darkTertiaryColor,
    ),
  );
}
