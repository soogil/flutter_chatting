import 'package:flutter_chatting/model/user.dart';

class SignInUser {
  static final SignInUser _instance = SignInUser._internal();

  factory SignInUser() {
    return _instance;
  }

  SignInUser._internal();

  User user;

  String get fcmToken => user.fcmToken;
  String get userName => user.userName;
}