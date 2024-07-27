import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/auth_wrapper.dart';
import 'package:owl/firebase_options.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/providers/theme_provider.dart';
import 'package:owl/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  await setUp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        )
      ],
      child: const Owl(),
    ),
  );
}

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class Owl extends StatelessWidget {
  const Owl({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 760),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const AuthWrapper(),
        );
      },
    );
  }
}
