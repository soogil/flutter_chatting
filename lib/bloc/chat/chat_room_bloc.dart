import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chat/chat_room_event.dart';
import 'package:flutter_chatting/bloc/chat/chat_room_state.dart';
import 'package:flutter_chatting/repository/user_repository.dart';

class ChatRoomBloc extends Bloc<ChatRoomInitEvent, ChatRoomInitState> {
  ChatRoomBloc() : super(ChatRoomInitState());

  final UserRepository repository = UserRepository();

  @override
  Stream<ChatRoomInitState> mapEventToState(ChatRoomInitEvent event) async* {
    if (event is ChatRoomInitEvent) {
      final users = await repository.getUsers();
      yield ChatRoomInitState(users: users);
    }
  }
}