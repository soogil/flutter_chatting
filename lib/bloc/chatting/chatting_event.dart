import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/user.dart';

class ChattingInitEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class SendChattingEvent extends ChattingInitEvent {
  SendChattingEvent(this.user, this.message);

  final User user;
  final String message;
  @override
  List<Object> get props => [user, message];
}
class ChattingUserListEvent extends ChattingInitEvent {}