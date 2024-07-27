import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  const ErrorPage({super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 150.r,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 4.h),
            Text(
              "Ooops...",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 4.h),
            Text(
              "Something went wrong.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Please try again.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.h),
            FilledButton(
              onPressed: onPressed,
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}
