import 'dart:convert';

import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/user.dart';

class PushMessage extends BaseModel {
  PushMessage.fromJson(Map<String, dynamic> json) :
        title = json['notification']['title'],
        message = json['notification']['body'],
        pushData = PushData.fromJson(json['data']);

  final String title;
  final String message;
  final PushData pushData;

  Message get messageUser => pushData.message;
  ChattingRoom get chattingRoom => pushData.chattingRoom;
}

class Notification {

}

// 임시데이터
class PushData {
  PushData.fromJson(Map json) :
        clickAction = json['click_action'],
        id = json['id'],
        status = json['status'],
        message = Message.fromJson(jsonDecode(json['message'])),
        chattingRoom = ChattingRoom.fromJson(jsonDecode(json['chattingRoom']));

  final String clickAction;
  final String id;
  final String status;
  final Message message;
  final ChattingRoom chattingRoom;
}