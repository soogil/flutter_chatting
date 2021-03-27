import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/repository/chat_repository.dart';
import 'package:flutter_chatting/repository/user_repository.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingInitState> {
  ChattingBloc(ChattingInitState state) : super(state);

  final UserRepository userRepository = UserRepository();
  final ChatRepository chatRepository = ChatRepository();

  @override
  Stream<ChattingInitState> mapEventToState(ChattingEvent event) async* {
    print('chat mapEventToState $event');
    if (event is ChattingInitEvent) {
      final rooms = await userRepository.getChattingRooms();
      yield ChattingRoomListState(rooms: rooms);
    } else if (event is SendChattingEvent) {
      await chatRepository.sendMessage(event.room);
      yield SendMessageState();
    }
  }
}