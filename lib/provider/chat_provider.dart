import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/user.dart';

class ChatProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future _createChattingRoom(String roomId, List<RoomUser> users) async {
    print('_createChattingRoom $roomId');

    await Future.forEach(users, (user) async {
      _database.reference().child('channelToken').child(user.fcmToken).update({'roomId': roomId});
    });
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
      _createChattingRoom(room.roomId, room.roomUsers).then((value) async =>
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