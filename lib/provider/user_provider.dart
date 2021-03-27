import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';

class UserProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<bool> registerUser(Map<String, dynamic> user) async {
    try {
      await _database.reference().child('users').push().set(user);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getUserByEmail(String email) async {
    try {
      final snapShot = await _database.reference()
          .child('users')
          .orderByChild('email')
          .equalTo(email)
          .limitToFirst(1).once().then((snapshot) => snapshot.value);

      return snapShot.entries
          .map((entry) => User.fromJson(entry.value))
          .first;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> getUsers() async {
    try {
      return await _database.reference().child('users').once().then((DataSnapshot snapShot) {
        return snapShot.value;
      });
    } catch(e) {
      throw Exception(e);
    }
  }

  Future getChattingRoomIds() async {
    return await _database.reference().child('channelToken').child(SignInUser().fcmToken).once().then((snapShot) => snapShot.value);
  }

  Future getChattingRoomById(String roomId) async {
    try {
      return await _database.reference().child('rooms').child(roomId).once().then((snapShot) => snapShot.value);
    } catch(e) {
      throw Exception(e);
    }
  }
}