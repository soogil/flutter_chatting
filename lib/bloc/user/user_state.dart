import 'package:equatable/equatable.dart';
import 'package:flutter_chatting/model/user.dart';

abstract class UserState<T extends BaseModel> extends Equatable {
  UserState({List<T> items}) : items = items ?? [];
  final List<T> items;
  @override
  List<Object> get props => [items];
}
class UserListState extends UserState<User> {
  UserListState({List<User> users}) : super(items: users);
}