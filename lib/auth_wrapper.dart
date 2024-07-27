import 'package:flutter/material.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/ui/pages/auth/email_verification_page.dart';
import 'package:owl/ui/pages/auth/login_page.dart';
import 'package:owl/ui/pages/error_page.dart';
import 'package:owl/ui/pages/loading_page.dart';
import 'package:owl/ui/pages/main_page.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = context.watch<AuthProvider>();
    if (auth.user == null) {
      return const LoginPage();
    } else if (!auth.user!.emailVerified) {
      return const EmailVerificationPage();
    } else {
      if (auth.owlUser == null) {
        return FutureBuilder(
          future: auth.getOwlUser(uid: auth.user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            } else if (snapshot.hasError) {
              return ErrorPage(
                onPressed: () {
                  auth.signOut();
                },
                buttonText: 'Go Back',
              );
            } else {
              if (snapshot.data!) {
                return const MainPage();
              } else {
                return ErrorPage(
                  onPressed: () {
                    auth.signOut();
                  },
                  buttonText: 'Go Back',
                );
              }
            }
          },
        );
      } else {
        return const MainPage();
      }
    }
  }
}
