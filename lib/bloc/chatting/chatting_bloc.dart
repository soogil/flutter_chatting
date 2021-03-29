import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/repository/user_repository.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingInitState> {
  ChattingBloc(ChattingInitState state) : super(state);

  final UserRepository userRepository = UserRepository();

  @override
  Stream<ChattingInitState> mapEventToState(ChattingEvent event) async* {
    print('chat mapEventToState $event');
    if (event is ChattingInitEvent) {
      final chattingRooms = await userRepository.getChattingRooms();
      yield ChattingRoomListState(chattingRooms);
    } else if (event is PushUpdateEvent) {
      final itemIndex = state.items.indexWhere((element) => element.roomId == event.roomId);
      state.items[itemIndex] = event.chattingRoom;
      yield ChattingRoomListState(state.items);
    }
  }
}