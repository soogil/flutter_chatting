import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_event.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_state.dart';
import 'package:flutter_chatting/repository/chat_repository.dart';

class ChattingScreenBloc extends Bloc<ChattingScreenEvent, ChattingScreenState> {
  ChattingScreenBloc() : super(ChattingScreenInitState());

  final ChatRepository chatRepository = ChatRepository();

  @override
  Stream<ChattingScreenState> mapEventToState(ChattingScreenEvent event) async* {
    print('chat mapEventToState $event');
    if (event is ChattingScreenInitEvent) {
      final messages = await chatRepository.getMessageList(event.roomId);
      print('ChattingScreenInitEvent ${messages.length}');
      yield ChattingScreenInitState(messages: messages);
    } else if (event is SendMessageEvent) {
      await chatRepository.sendMessage(event.room);
      yield SendMessageState();
    }
  }
}