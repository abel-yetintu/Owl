import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 32.w),
    centerTitle: true,
  );

  static final darkAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 32.w),
    centerTitle: true,
  );
}
