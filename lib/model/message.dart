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
    this.msg,
    this.time
  });

  Message.fromJson(Map json)
      :
        fcmToken = json['fcmToken'],
        userName = json['userName'],
        // type = MessageType.values[json['type']],
        msg = json['message'],
        time = json['messageTime'];

  // MessageType type;

  final String fcmToken;
  final String userName;
  String msg;
  int time;

  Map<String, dynamic> get toJson => {
        // 'type': type.index,
        'message': msg,
        'messageTime': time,
        'userName': userName,
        'fcmToken': fcmToken,
      };

  @override
  List<Object> get props => [ // type,
    msg, time, fcmToken, userName];
}