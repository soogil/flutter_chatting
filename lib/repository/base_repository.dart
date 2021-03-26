import 'package:flutter_chatting/provider/sign_in_provider.dart';
import 'package:flutter_chatting/provider/user_provider.dart';

abstract class Repository {
  final LoginProvider loginProvider = LoginProvider();
  final UserProvider userProvider = UserProvider();
}