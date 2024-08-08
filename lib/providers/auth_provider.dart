import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/services/auth_service.dart';
import 'package:owl/services/database_service.dart';
import 'package:tuple/tuple.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();


  bool _loading = false;
  bool get loading => _loading;

  User? _user;
  User? get user => _user;

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }


  Future<bool> signInWithEmailAndPassword({required String email, required String password}) async {
    _loading = true;
    notifyListeners();
    try {
      final user = await _authService.signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (_) {
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<Tuple2<bool, String?>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String userName,
  }) async {
    _loading = true;
    notifyListeners();
    try {
      final isUserNameAvailable = await DatabaseService().isUserNameAvailable(userName: userName);
      if (isUserNameAvailable) {
        final user = await _authService.signUpWithEmailAndPassword(email: email, password: password);
        if (user != null) {
          final owlUser = OwlUser(uid: user.uid, email: user.email!, userName: userName, fullName: fullName, profilePicture: "");
          await DatabaseService().createUserDocument(owlUser: owlUser);
          return const Tuple2(true, null);
        } else {
          return const Tuple2(false, null);
        }
      } else {
        return const Tuple2(false, 'User name already taken');
      }
    } on FirebaseAuthException catch (_) {
      return const Tuple2(false, null);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> sendEmailVerification() async {
    return await _authService.sendEmailVerification();
  }

  Future<void> isEmailVerified() async {
    try {
      await _authService.reloadUser();
      _user = _authService.user;
      notifyListeners();
    } on FirebaseAuthException catch (_) {}
  }

  Future<bool> signOut() async {
    try {
      await _authService.signOut();
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  Future<bool> resetPassword({required String email}) async {
    return await _authService.resetPassword(email: email);
  }
}
