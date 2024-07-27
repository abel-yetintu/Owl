import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/utils/alert.dart';
import 'package:owl/utils/constants/colors.dart';
import 'package:owl/utils/extension.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700, color: CustomColors.darkGrey),
        ),
        flexibleSpace: Image.asset(
          "assets/images/background.jpg",
          fit: BoxFit.cover,
        ),
        toolbarHeight: 100.h,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32.h),
              Text(
                'Enter your email address and we will send you a password reset link',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              SizedBox(height: 16.h),
              FilledButton(
                onPressed: () async {
                  final email = _emailTextEditingController.text;
                  if (email.isValidEmail) {
                    authProvider.resetPassword(email: email).then((value) {
                      if (value) {
                        Alert.showToast(context: context, text: "Check your email.", icon: Icons.email);
                      } else {
                        Alert.showErrorToast(context: context, text: "Reset failed. Please try agian.");
                      }
                      print(value);
                    });
                  } else {
                    Alert.showErrorToast(context: context, text: "Enter a valid email.");
                  }
                },
                child: const Text('Reset Password'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
