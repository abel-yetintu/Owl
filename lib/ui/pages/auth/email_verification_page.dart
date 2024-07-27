import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/utils/alert.dart';
import 'package:owl/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  Timer? _timer;
  bool _canResendEmail = false;

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _sendVerificationEmail();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _checkEmailVerified();
    });
  }

  Future<void> _sendVerificationEmail() async {
    context.read<AuthProvider>().sendEmailVerification().then((value) {
      if (value) {
        if (mounted) {
          Alert.showToast(context: context, text: 'Check your email.', icon: Icons.email);
          setState(() {
            _canResendEmail = false;
          });
        }
        Future.delayed(const Duration(minutes: 1)).then((_) {
          if (mounted) {
            setState(() {
              _canResendEmail = true;
            });
          }
        });
      } else {
        if (mounted) {
          setState(() {
            _canResendEmail = true;
          });
          Alert.showErrorToast(context: context, text: "Error. Please try again.");
        }
      }
    });
  }

  Future<void> _checkEmailVerified() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.isEmailVerified();
    if (authProvider.user != null && authProvider.user!.emailVerified) {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Verify your email',
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
                  'A verification letter has been sent to your email adress.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: _canResendEmail ? _sendVerificationEmail : null,
                  child: const Text('Resend'),
                ),
                SizedBox(
                  height: 16.h,
                ),
                OutlinedButton(
                  onPressed: () {
                    context.read<AuthProvider>().signOut();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      );
}
