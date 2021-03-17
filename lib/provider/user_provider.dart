import 'package:firebase_database/firebase_database.dart';

class UserProvider {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> registerUser(Map<String, dynamic> user) async {
    await database.reference().push().set(user).then((_) {
      print('registerUser $user');
      return true;
    }).catchError((e) {
      return false;
    });
    return false;
  }
}