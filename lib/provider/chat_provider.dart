import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/user.dart';

class ChatProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future _createChattingRoom(String roomId, List<RoomUser> users) async {
    await Future.forEach(users, (user) async {
      _database.reference()
          .child('channelToken')
          .child(user.fcmToken)
          .child('roomIds').once().then((snapShot) {
            final List roomIds = snapShot.value == null
                ? [] : List<String>.from(snapShot.value);

            if (!roomIds.contains(roomId)) roomIds.add(roomId);

            _database.reference()
                .child('channelToken')
                .child(user.fcmToken)
                .update({'roomIds': roomIds});
      });
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

  Future updateRoom(RoomInfo roomInfo, Map<String, dynamic> body) async {
    try {
      _createChattingRoom(roomInfo.roomId, roomInfo.roomUsers).then((value) async =>
     // print(''));
      await _database.reference().child('rooms').child(roomInfo.roomId).update(body));
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