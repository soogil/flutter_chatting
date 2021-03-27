import 'package:flutter_chatting/model/message.dart';

abstract class ChattingScreenState {
  ChattingScreenState({List<Message> messages}) : messages = messages ?? List();
  final List<Message> messages;
}
class ChattingScreenInitState extends ChattingScreenState {
  ChattingScreenInitState({List<Message> messages}) : super(messages: messages);
}
class SendMessageState extends ChattingScreenState {}