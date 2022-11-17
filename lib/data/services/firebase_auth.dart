import 'package:firebase_auth/firebase_auth.dart';

class _FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  
  bool hasSession() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    if (_firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUpEmail(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (_firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

}

final firebaseAuthService = _FirebaseAuthService();