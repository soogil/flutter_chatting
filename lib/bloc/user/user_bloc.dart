import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/user/user_event.dart';
import 'package:flutter_chatting/bloc/user/user_state.dart';
import 'package:flutter_chatting/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserListState());

  final UserRepository userRepository = UserRepository();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserListEvent) {
      final users = await userRepository.getUsers();
      yield UserListState(users: users);
    } else if (event is GetChattingRoomEvent) {
      final roomID = await userRepository.getChattingRoomInfo(event.myToken, event.otherUserToken);
      yield CreateChattingRoomState(roomID, users: state.items, chattingRoomUsers: event.users);
    }
  }
}