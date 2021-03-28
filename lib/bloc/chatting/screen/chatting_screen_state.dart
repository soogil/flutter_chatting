import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/user.dart';

abstract class ChattingScreenState extends Equatable {
  ChattingScreenState({List<Message> messages, @required this.room}) : messages = messages ?? List();
  final List<Message> messages;
  final ChattingRoom room;

  String get roomId => room.roomId;
  String get userToken => myInfo.fcmToken;
  String get userName => myInfo.userName;
  RoomUser get myInfo => room.myInfo;
  @override
  List<Object> get props => [messages];
}
class ChattingScreenInitState extends ChattingScreenState {
  ChattingScreenInitState({List<Message> messages, @required ChattingRoom room}) : super(messages: messages, room: room);
}
class SendMessageState extends ChattingScreenState {
  SendMessageState({List<Message> messages, @required ChattingRoom room}) : super(messages: messages, room: room);
}