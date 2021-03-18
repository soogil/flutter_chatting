import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/provider/user_provider.dart';

class UserRepository {
  final UserProvider userProvider = UserProvider();
  
  Future<bool> registerUser(Map<String, dynamic>user) async => await userProvider.registerUser(user);

  Future<User> getUserByEmail(String email) async {
    final Map snapShot = await userProvider.getUserByEmail(email);

    return snapShot.entries.map((entry) => User.fromJson(entry.value)).first;
  }

  Future<List<User>> getUsers() async {
    final Map snapShot = await userProvider.getUsers();
    final List<User> users = [];

    snapShot.values.forEach((element) {
      final user = User.fromJson(element);
      if(user.email != SignInUser().user.email) users.add(user);
    });

    return users;
  }
}