import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/repository/user_repository.dart';

class ChattingBloc extends Bloc<ChattingInitEvent, ChattingInitState> {
  ChattingBloc() : super(ChattingInitState());

  final UserRepository repository = UserRepository();

  @override
  Stream<ChattingInitState> mapEventToState(ChattingInitEvent event) async* {
    if (event is ChattingInitEvent) {
      final users = await repository.getUsers();
      yield ChattingRoomListState(rooms: users);
    } else if (event is ChattingUserListEvent) {
      final users = await repository.getUsers();
      yield UserListState(users: users);
    } else if (event is SendChattingEvent) {
      // event.
    }
  }
}