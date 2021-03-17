import 'package:flutter_chatting/provider/user_provider.dart';

class UserRepository {
  final UserProvider userProvider = UserProvider();
  
  registerUser(Map<String, dynamic>user) => userProvider.registerUser(user);
}