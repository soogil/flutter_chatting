import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chatting/provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider = LoginProvider();

  Future<FirebaseUser> login(String id, String password) => loginProvider.signIn(id, password);
}