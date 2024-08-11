import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:owl/utils/constants/colors.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: HexColor('#212121'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          SizedBox(
            width: 250.w,
            child: Image.asset('assets/images/hedwig.png'),
          ),
          const Spacer(),
          Text(
            'Welcome to Owl',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: CustomColors.lightGrey),
          ),
          SizedBox(height: 32.h),
          Text(
            "Step into the magical world of Owl, Connect with friends and fellow wizards instantly. Let's get started on your journey!",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
