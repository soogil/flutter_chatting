import 'package:flutter_chatting/model/user.dart';

enum MessageType {
  left,
  right,
}

class Message extends BaseModel {
  Message({
    // this.type,
    this.fcmToken,
    this.userName,
    this.message,
    this.messageTime
  });

  Message.fromJson(Map json)
      : fcmToken = json['fcmToken'],
        userName = json['userName'],
        message = json['message'],
        messageTime = json['messageTime'];

  // MessageType type;

  final String fcmToken;
  final String userName;
  String message;
  int messageTime;

  Map<String, dynamic> get toJson => {
        // 'type': type.index,
        'message': message,
        'messageTime': messageTime,
        'userName': userName,
        'fcmToken': fcmToken,
      };

  @override
  List<Object> get props => [ // type,
    message, messageTime, fcmToken, userName];
}