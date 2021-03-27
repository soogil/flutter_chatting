import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/model/user.dart';

class ChattingInitState<T extends BaseModel> {
  ChattingInitState({List<T> items}) : items = items ?? List();
  final List<T> items;
}
class ChattingRoomListState extends ChattingInitState<ChattingRoom> {
  ChattingRoomListState({List<ChattingRoom> rooms}) : super(items: rooms);
}
class SendMessageState extends ChattingInitState {
}