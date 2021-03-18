import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chatting/model/user.dart';

class UserProvider {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> registerUser(Map<String, dynamic> user) async {
    try {
      await database.reference().child('users').push().set(user);
      return true;
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<Map> getUserByEmail(String email) async {
    try {
      return await database.reference()
          .child('users')
          .orderByChild('email')
          .equalTo(email)
          .limitToFirst(1).once().then((snapshot) => snapshot.value);
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<Map> getUsers() async {
    try {
      return await database.reference().child('users').once().then((DataSnapshot snapShot) {
        return snapShot.value;
      });
    } catch(e) {
      throw Exception(e);
    }
  }
}