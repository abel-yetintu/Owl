import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/auth_wrapper.dart';
import 'package:owl/firebase_options.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/providers/theme_provider.dart';
import 'package:owl/services/image_picker_service.dart';
import 'package:owl/theme/theme.dart';
import 'package:owl/ui/pages/onboarding/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setUp();
  var prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPreferences>(
          create: (context) => prefs,
        ),
        Provider<ImagePickerService>(
          create: (context) => ImagePickerService(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(prefs: context.read<SharedPreferences>()),
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
    final themeProvider = context.read<ThemeProvider>();
    final prefs = context.read<SharedPreferences>();
    final showOnboardingPage = prefs.getBool('showOnboardingPage') ?? true;

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
          home: showOnboardingPage ? const OnboardingPage() : const AuthWrapper(),
        );
      },
    );
  }
}
