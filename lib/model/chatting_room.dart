import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';

class ChattingRoom extends BaseModel {
  ChattingRoom({this.roomId, this.message, this.messageTime, this.roomUsers});

  ChattingRoom.fromJson(Map json) :
        roomId = json['roomId'],
        message = json['message'],
        messageTime = json['messageTime'],
        roomUsers = List<RoomUser>.generate(json['roomUsers']?.length, (index) => RoomUser.fromJson(json['roomUsers'][index]));
  final String roomId;
  final List<RoomUser> roomUsers;
  String message;
  int messageTime;

  Map<String, dynamic> get toJson => {
    'roomId': roomId,
    'message': message,
    'messageTime': messageTime,
    'roomUsers' : List.generate(roomUsers.length, (index) => roomUsers[index].toJson)
  };

  RoomUser get myInfo => roomUsers.firstWhere((element) => element.fcmToken == SignInUser().fcmToken);
  RoomUser get otherInfo => roomUsers.firstWhere((element) => element.fcmToken != SignInUser().fcmToken);
  String get otherUserName => roomUsers.firstWhere((element) => element.fcmToken != SignInUser().fcmToken).userName;
  String get lastMessage => message;
  String get lastMessageTime {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(messageTime);
    final String hour = '${dateTime.hour >= 12 ? '오후' : '오전'} ${dateTime.hour >= 13 ? dateTime.hour - 12 : dateTime.hour == 24 ? 0 : dateTime.hour}';
    final String minute = dateTime.minute.toString();
    return '$hour:$minute';
  }
}