import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/user.dart';

class ChattingRoom extends BaseModel {
  ChattingRoom({this.roomId, this.message, this.user});

  ChattingRoom.fromJson(Map json) :
        roomId = json['roomId'],
        message = Message(msg: json['lastMessage'], time: json['lastDateTime']),
        user = User(name: json['userName'], email: json['userEmail']);
  final String roomId;
  final Message message;
  final User user;

  Map<String, dynamic> get toJson => {
    'roomId': roomId,
    'lastMessage': message?.msg ?? '',
    'lastDateTime': message?.time ?? 0,
    'userName': user.name,
    'userEmail': user.email,
  };

  String get name => user.name;
  String get email => user.email;
  String get lastMessage => message.msg;
  String get lastMessageTime {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(message.time);
    final String hour = '${dateTime.hour >= 12 ? '오후' : '오전'} ${dateTime.hour >= 13 ? dateTime.hour - 12 : dateTime.hour == 24 ? 0 : dateTime.hour}';
    final String minute = dateTime.minute.toString();
    return '$hour:$minute';
  }
}