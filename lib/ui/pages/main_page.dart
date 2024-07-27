import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    OwlUser owlUser = context.read<AuthProvider>().owlUser!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: ${owlUser.email}'),
            SizedBox(height: 6.h),
            Text('Full Name: ${owlUser.fullName}'),
            SizedBox(height: 6.h),
            Text('User Name: ${owlUser.userName}'),
            SizedBox(height: 6.h),
            FilledButton(
              child: const Text(
                'Log out',
              ),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
