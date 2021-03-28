import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/message.dart';

abstract class ChattingScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ChattingScreenInitEvent extends ChattingScreenEvent {}
class SendMessageEvent extends ChattingScreenEvent {
  SendMessageEvent(this.msg);

  final Message msg;

  int get time => msg.messageTime;
  String get message => msg.message;
  int get messageTime => msg.messageTime;
  @override
  List<Object> get props => [msg];
}