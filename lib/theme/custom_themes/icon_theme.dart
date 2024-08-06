import 'package:flutter/material.dart';
import 'package:owl/utils/constants/colors.dart';

class CustomIconTheme {
  CustomIconTheme._();

  static final lightIconTheme = IconThemeData(
    color: CustomColors.darkGrey,
  );

  static final darkIconTheme = IconThemeData(
    color: CustomColors.lightGrey,
  );
}
