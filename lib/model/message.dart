import 'package:flutter_chatting/model/user.dart';

enum Type {
  left,
  right,
}

class Message extends BaseModel {
  Message({this.type, this.msg, this.time});

  Message.fromJson(Map json)
      : type = Type.values[json['type']],
        msg = json['message'],
        time = json['messageTime'];

  Type type;
  String msg;
  int time;

  Map<String, dynamic> get toJson => {
      'type': type.index,
      'message': msg,
      'messageTime': time,
  };

  @override
  List<Object> get props => [type, msg, time];
}