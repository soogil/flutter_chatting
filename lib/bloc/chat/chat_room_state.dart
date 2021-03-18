import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/user.dart';

class ChatRoomInitState extends Equatable {
  ChatRoomInitState({List<User> users}) : users = users ?? List();
  final List<User> users;
  @override
  List<Object> get props => [];
}