import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:owl/utils/constants/colors.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
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
            child: Image.asset('assets/images/hedwig_letter.png'),
          ),
          const Spacer(),
          Text(
            'Magical Messaging',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: CustomColors.lightGrey),
          ),
          SizedBox(height: 32.h),
          Text(
            "Send messages that fly like owls! With Owl, your messages are swift and enchanting. Enjoy seamless chats with a touch of magic.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
