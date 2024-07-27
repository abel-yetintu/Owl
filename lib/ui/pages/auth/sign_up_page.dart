// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/utils/alert.dart';
import 'package:owl/utils/constants/colors.dart';
import 'package:owl/utils/extension.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _fullName, _userName, _email, _password;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: CustomColors.darkGrey),
          ),
          flexibleSpace: Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.cover,
          ),
          toolbarHeight: 100.h,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 32.h),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Ronald Weasley',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter full name';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _fullName = newValue?.trim();
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'User Name',
                          hintText: 'ron.weasley',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter user name';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _userName = newValue?.trim().toLowerCase();
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'ronweasley@owl.com',
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (!value!.isValidEmail) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _email = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (!value!.isValidPassword) {
                            return "Password must be at least 8 characters long.";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _password = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Passowrd',
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value != _password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return FilledButton(
                            onPressed: authProvider.loading
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      authProvider
                                          .signUpWithEmailAndPassword(
                                              email: _email!, password: _password!, fullName: _fullName!, userName: _userName!)
                                          .then((value) {
                                        if (value.item1) {
                                          Navigator.pop(context);
                                        } else {
                                          if (value.item2 != null) {
                                            Alert.showErrorToast(context: context, text: value.item2!);
                                          } else {
                                            Alert.showErrorToast(context: context, text: "Sign up failed. Please try again.");
                                          }
                                        }
                                      });
                                    }
                                  },
                            child: authProvider.loading
                                ? SizedBox(
                                    height: 20.w,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.lightGrey,
                                    ),
                                  )
                                : const Text('Sign Up'),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Row(
                          children: [
                            Text(
                              "Already have an accout?",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w700),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
