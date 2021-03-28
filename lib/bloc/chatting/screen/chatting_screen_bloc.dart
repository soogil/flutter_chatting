import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_event.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_state.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/repository/chat_repository.dart';
import 'package:flutter_chatting/service/push_service.dart';

class ChattingScreenBloc extends Bloc<ChattingScreenEvent, ChattingScreenState> {
  ChattingScreenBloc(ChattingScreenInitState state) : super(state);

  final ChatRepository chatRepository = ChatRepository();

  @override
  Stream<ChattingScreenState> mapEventToState(ChattingScreenEvent event) async* {
    print('chat mapEventToState $event');
    if (event is ChattingScreenInitEvent) {
      final messages = await chatRepository.getMessageList(state.roomId);
      yield ChattingScreenInitState(messages: messages, room: state.room);
    } else if (event is SendMessageEvent) {
      await chatRepository.sendMessage(state.room, event.msg);
      final messages = List<Message>.from(state.messages);
      final message = Message(
          // type: event.type,
          fcmToken: state.userToken,
          userName: state.userName,
          messageTime: event.time,
          message: event.message
      );
      final isSuccess = PushService().sendFcmMessage(message.message, message.fcmToken);

      print('SendMessageEvent ${state.room.toJson}');
      messages.insert(0, message);
      yield SendMessageState(messages: messages, room: state.room);
    }
  }
}