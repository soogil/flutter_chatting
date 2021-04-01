import 'package:flutter_chatting/model/chatting_room.dart';

class ChattingInitState {
  ChattingInitState({List<ChattingRoom> items}) : items = items ?? List();
  final List<ChattingRoom> items;
}
class ChattingRoomListState extends ChattingInitState {
  ChattingRoomListState(List<ChattingRoom> rooms) : super(items: rooms);
}