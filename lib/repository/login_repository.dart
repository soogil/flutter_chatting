import 'package:flutter_chatting/provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider = LoginProvider();

  Future<bool> signIn(String id, String password) async => await loginProvider.signIn(id, password) != null;

  Future<bool> signUp(String id, String password) async => await loginProvider.signUp(id, password) != null;
}