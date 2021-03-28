import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/room.dart';

abstract class ChattingScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ChattingScreenInitEvent extends ChattingScreenEvent {
  ChattingScreenInitEvent(this.roomId);
  final String roomId;
}
class SendMessageEvent extends ChattingScreenEvent {
  SendMessageEvent(this.room);

  final ChattingRoom room;


  // MessageType get type => room.message.type;
  int get time => room.message.time;
  String get token => room.message.fcmToken;
  String get message => room.lastMessage;
  String get userName => room.message.userName;
  @override
  List<Object> get props => [room];
}