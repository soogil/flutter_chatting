import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';

class ChatProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future _createChattingRoom(String roomId, String userFcmToken) async {
    print('$roomId $userFcmToken');
    await _database.reference().child('channelToken').child(SignInUser().fcmToken).update({'roomId': roomId});
    await _database.reference().child('channelToken').child(userFcmToken).update({'roomId': roomId});
  }

  Future getMessageList(String roomId) async {
    try {
      return await _database.reference()
          .child('messagesByRoomId')
          .child(roomId)
          .once().then((snapshot) => snapshot.value);
    } catch(e) {
      throw Exception(e);
    }
  }

  Future updateRoom(ChattingRoom room) async {
    try {
      _createChattingRoom(room.roomId, room.user.fcmToken).then((value) async =>
      await _database.reference().child('rooms').child(room.roomId).update(room.toJson));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future sendMessage(String roomId, Message message) async {
    try {
      return await _database.reference().child('messagesByRoomId').child(roomId).push().set(message.toJson);
    } catch(e) {
      throw Exception(e);
    }
  }
}