import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chatting/model/message.dart';

class ChatProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<bool> registerUser(Map<String, dynamic> user) async {
    try {
      await _database.reference().child('users').push().set(user);
      return true;
    } catch(e) {
      throw Exception(e);
    }
  }

  Future<Object> getMessageList(String roomId) async {
    try {
      return await _database.reference()
          .child('roomIds')
          .equalTo(roomId)
          .once().then((snapshot) => snapshot.value);
    } catch(e) {
      throw Exception(e);
    }
  }

  Future sendMessage(String roomId, Message message) async {
    try {
      return await _database.reference().child('roomIds').child(roomId).push().set(message.toMap);
    } catch(e) {

    }
  }
}