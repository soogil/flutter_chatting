import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/chatting_room.dart';

abstract class ChattingEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ChattingInitEvent extends ChattingEvent {}
class SendChattingEvent extends ChattingEvent {
  SendChattingEvent(this.room);

  final ChattingRoom room;
  @override
  List<Object> get props => [room];
}