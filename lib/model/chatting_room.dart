import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';

class ChattingRoom extends BaseModel {
  ChattingRoom({this.roomInfo, this.message, this.messageTime,});

  ChattingRoom.fromJson(Map json) :
        roomInfo = RoomInfo.fromJson(json),
        message = json['message'],
        messageTime = json['messageTime'];

  final RoomInfo roomInfo;
  String message;
  int messageTime;

  Map<String, dynamic> get toJson => {
    ...roomInfo.toJson,
    'message': message,
    'messageTime': messageTime,
  };

  String get roomId => roomInfo.roomId;
  List<User> get roomUsers => roomInfo.roomUsers;
  RoomUser get myInfo => roomInfo.myInfo;
  RoomUser get otherInfo => roomInfo.otherInfo;
  String get otherUserName => roomInfo.otherUserName;
  String get lastMessage => message;
  String get lastMessageTime {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(messageTime);
    final String hour = '${dateTime.hour >= 12 ? '오후' : '오전'} ${dateTime.hour >= 13 ? dateTime.hour - 12 : dateTime.hour == 24 ? 0 : dateTime.hour}';
    final String minute = dateTime.minute.toString();
    return '$hour:$minute';
  }
}

class RoomInfo {
  RoomInfo({this.roomId, this.roomUsers,});

  RoomInfo.fromJson(Map json) :
        roomId = json['roomId'],
        roomUsers = List<RoomUser>.generate(json['roomUsers']?.length, (index) => RoomUser.fromJson(json['roomUsers'][index]));

  final String roomId;
  final List<RoomUser> roomUsers;

  Map<String, dynamic> get toJson => {
    'roomId': roomId,
    'roomUsers' : List.generate(roomUsers.length, (index) => roomUsers[index].toJson)
  };

  RoomUser get myInfo => roomUsers.firstWhere((element) => element.fcmToken == SignInUser().fcmToken);
  RoomUser get otherInfo => roomUsers.firstWhere((element) => element.fcmToken != SignInUser().fcmToken);
  String get otherUserName => roomUsers.firstWhere((element) => element.fcmToken != SignInUser().fcmToken).userName;
}