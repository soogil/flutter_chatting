import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String id, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: id, password: password);
      return result.user;
    }
    catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}