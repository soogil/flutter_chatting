import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/user.dart';

abstract class ChattingScreenState extends Equatable {
  ChattingScreenState({List<Message> messages, @required this.roomInfo}) : messages = messages ?? List();
  final List<Message> messages;
  final RoomInfo roomInfo;

  String get roomId => roomInfo.roomId;
  String get myToken => myInfo.fcmToken;
  String get myName => myInfo.userName;
  String get otherToken => roomInfo.otherInfo.fcmToken;
  RoomUser get myInfo => roomInfo.myInfo;
  Map<String, dynamic> get chattingRoomToJson => lastMessage != null ? {
    ...roomInfo.toJson,
    ...{
      'message': lastMessage.message,
      'messageTime': lastMessage.messageTime,
    },
  } : {};
  Message get lastMessage => messages?.first;
  @override
  List<Object> get props => [messages];
}
class ChattingScreenInitState extends ChattingScreenState {
  ChattingScreenInitState({List<Message> messages, @required RoomInfo room}) : super(messages: messages, roomInfo: room);
}
class SendMessageState extends ChattingScreenState {
  SendMessageState({List<Message> messages, @required RoomInfo room}) : super(messages: messages, roomInfo: room);
}
class PushUpdateScreenState extends ChattingScreenState {
  PushUpdateScreenState({List<Message> messages, @required RoomInfo room}) : super(messages: messages, roomInfo: room);
}