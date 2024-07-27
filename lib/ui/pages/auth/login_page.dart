// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/ui/pages/auth/forgot_password_page.dart';
import 'package:owl/ui/pages/auth/sign_up_page.dart';
import 'package:owl/utils/alert.dart';
import 'package:owl/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: Image.asset(
                    'assets/icons/owl.png',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 32.h),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'harrypotter@owl.com',
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter an email";
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
                          if (value!.isEmpty) {
                            return "Enter a password";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _password = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                        },
                        child: Text(
                          'Forgot password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return FilledButton(
                            onPressed: authProvider.loading
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      authProvider.signInWithEmailAndPassword(email: _email!, password: _password!).then((value) {
                                        if (!value) {
                                          Alert.showErrorToast(context: context, text: "Login failed. Please try again.");
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
                                : const Text('Login'),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            child: Text(
                              'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                            },
                          ),
                        ],
                      ),
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
