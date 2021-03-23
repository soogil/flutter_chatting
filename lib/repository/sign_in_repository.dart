import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chatting/provider/sign_in_provider.dart';

class SignInRepository {
  final LoginProvider loginProvider = LoginProvider();

  Future<FirebaseUser> signIn(String id, String password) async => await loginProvider.signIn(id, password);

  Future<bool> signUp(String id, String password) async => await loginProvider.signUp(id, password) != null;
}