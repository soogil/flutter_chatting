import 'package:equatable/equatable.dart';
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
  @override
  List<Object> get props => [room];
}