import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Exposing current user
  User? get user {
    return _auth.currentUser;
  }

  // Reload user
  Future<void> reloadUser() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser?.reload();
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  // Exposing AuthStateChanges
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Forgot password
  Future<bool> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  // Email verification
  Future<bool> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }
}
