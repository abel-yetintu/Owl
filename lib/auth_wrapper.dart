import 'package:flutter/material.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/providers/conversation_provider.dart';
import 'package:owl/providers/owl_user_provider.dart';
import 'package:owl/providers/search_provider.dart';
import 'package:owl/providers/selected_tab_provider.dart';
import 'package:owl/services/storage_service.dart';
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
    }
     else if (!auth.user!.emailVerified) {
      return const EmailVerificationPage();
    }
    else {
      return ChangeNotifierProvider<OwlUserProvider>(
        create: (context) => OwlUserProvider(uid: auth.user!.uid),
        child: Consumer<OwlUserProvider>(
          builder: (context, provider, child) {
            if (provider.loading) {
              return const LoadingPage();
            } else {
              if (provider.owlUser == null) {
                return ErrorPage(
                  onPressed: () {
                    auth.signOut();
                  },
                  buttonText: 'Go Back',
                );
              } else {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (context) => SearchProvider()),
                    ChangeNotifierProvider(create: (context) => ConversationProvider(uid: provider.owlUser!.uid)),
                    ChangeNotifierProvider(create: (context) => SelectedTabProvider()),
                    Provider<StorageService>(create: (context) => StorageService()),
                  ],
                  child: const MainPage(),
                );
              }
            }
          },
        ),
      );
    }
  }
}
