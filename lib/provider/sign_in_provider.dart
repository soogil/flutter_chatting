import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String id, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: id, password: password);
      return result.user;
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future<FirebaseUser> signUp(String id, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: id,
          password: password
      );
      return result.user;
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}