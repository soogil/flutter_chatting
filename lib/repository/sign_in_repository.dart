import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/repository/base_repository.dart';
import 'package:flutter_chatting/service/push_service.dart';

class SignInRepository extends Repository {
  Future<FirebaseUser> signIn(String id, String password) async {
    return await loginProvider.signIn(id, password).then((fbUser) async {
      SignInUser().user = await userProvider.getUserByEmail(fbUser.email);
      return fbUser;
    });
  }

  Future<bool> signUp(String name, String id, String password) async  {
    final token = await PushService().token;
    final user = User(name, id, password, token);
    final fbUser = await loginProvider.signUp(id, password);
    if(fbUser != null) {
      return await userProvider.registerUser(user.toMap);
    }

    return false;
  }
}