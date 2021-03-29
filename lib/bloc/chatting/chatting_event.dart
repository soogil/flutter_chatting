
import 'package:flutter_chatting/model/chatting_room.dart';

abstract class ChattingEvent {}
class ChattingInitEvent extends ChattingEvent {}
class PushUpdateEvent extends ChattingEvent {
  PushUpdateEvent(this.chattingRoom);

  final ChattingRoom chattingRoom;

  String get roomId => chattingRoom.roomId;
}