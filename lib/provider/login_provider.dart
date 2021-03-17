import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String id, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(email: id, password: password);
      return result.user;
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future<FirebaseUser> signUp(String id, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: id,
          password: password
      );
      return result.user;
    }
    catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}