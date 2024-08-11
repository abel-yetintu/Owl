import 'package:flutter/material.dart';
import 'package:owl/auth_wrapper.dart';
import 'package:owl/ui/pages/onboarding/intro_page1.dart';
import 'package:owl/ui/pages/onboarding/intro_page2.dart';
import 'package:owl/ui/pages/onboarding/intro_page3.dart';
import 'package:owl/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool _onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                _onLastPage = value == 2;
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: CustomColors.lightGrey),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotColor: CustomColors.lightGrey,
                    activeDotColor: CustomColors.secondaryColor,
                  ),
                ),
                _onLastPage
                    ? GestureDetector(
                        onTap: () {
                          context.read<SharedPreferences>().setBool('showOnboardingPage', false);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const AuthWrapper();
                            }),
                          );
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: CustomColors.secondaryColor),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: CustomColors.lightGrey),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
