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
    if (event is ChattingScreenInitEvent) {
      final messages = await chatRepository.getMessageList(state.roomId);
      yield ChattingScreenInitState(messages: messages, room: state.roomInfo);
    } else if (event is SendMessageEvent) {
      await chatRepository.sendMessage(state.roomInfo, event.msg);
      final messages = List<Message>.from(state.messages);

      final Map<String, dynamic> data = {
        "chattingRoom": {...event.msg.toJsonMessage, ...state.roomInfo.toJson},
        ...{
          "message": event.msg.toJson
        }
      };
      PushService().sendFcmMessage(event.msg.message, state.otherToken, data: data);
      messages.insert(0, event.msg);
      yield SendMessageState(messages: messages, room: state.roomInfo);
    } else if (event is PushUpdateScreenEvent) {
      final messages = List<Message>.from(state.messages);
      messages.insert(0, event.msg);
      yield PushUpdateScreenState(messages: messages, room: state.roomInfo);
    }
  }
}