import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:owl/utils/constants/colors.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
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
            child: Image.asset('assets/images/map.jpg'),
          ),
          const Spacer(),
          Text(
            'Discover and Chat',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: CustomColors.lightGrey),
          ),
          SizedBox(height: 32.h),
          Text(
            "Search for friends and start new chats effortlessly. Use the search feature to find fellow wizards and begin your magical conversations.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
