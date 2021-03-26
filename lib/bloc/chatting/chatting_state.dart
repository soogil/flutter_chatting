import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/user.dart';

class ChattingInitState extends Equatable {
  ChattingInitState({List<User> items}) : items = items ?? List();
  final List<User> items;
  @override
  List<Object> get props => [];
}
class ChattingRoomListState extends ChattingInitState {
  ChattingRoomListState({List<User> rooms}) : super(items: rooms);
}
class UserListState extends ChattingInitState {
  UserListState({List<User> users}) : super(items: users);
}
class SendMessageState extends ChattingInitState {

}