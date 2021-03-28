import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/message.dart';

abstract class ChattingScreenState extends Equatable {
  ChattingScreenState({List<Message> messages}) : messages = messages ?? List();
  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}
class ChattingScreenInitState extends ChattingScreenState {
  ChattingScreenInitState({List<Message> messages}) : super(messages: messages);
}
class SendMessageState extends ChattingScreenState {
  SendMessageState({List<Message> messages}) : super(messages: messages);
}