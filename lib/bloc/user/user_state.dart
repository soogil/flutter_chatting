import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:uuid/uuid.dart';

abstract class UserState<T extends BaseModel> {
  UserState({List<T> items}) : items = items ?? [];
  final List<T> items;
}
class UserListState extends UserState<User> {
  UserListState({List<User> users}) : super(items: users);
}
class CreateChattingRoomState extends UserState<User> {
  CreateChattingRoomState(this._roomId, {@required List<User> users, @required this.chattingRoomUsers, }) : super(items: users);

  final String _roomId;
  final List<RoomUser> chattingRoomUsers;

  String get roomId => _roomId ?? Uuid().v4();
}