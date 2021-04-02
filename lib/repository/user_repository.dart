import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/repository/base_repository.dart';

class UserRepository extends Repository {
  Future<List<User>> getUsers() async {
    final Map userMap = await userProvider.getUsers();
    final List<User> users = [];

    userMap.values.forEach((element) {
      final user = User.fromJson(element);
      if (user.email != SignInUser().user.email) users.add(user);
    });

    return users;
  }

  Future<List<ChattingRoom>> getChattingRooms() async {
    final List roomIds = await userProvider.getChattingRoomIds();
    final List<ChattingRoom> chattingRooms = [];

    await Future.forEach(roomIds, (roomId) async {
      final roomJson = await userProvider.getChattingRoomById(roomId);

      print('getChattingRooms $roomJson');
      chattingRooms.add(ChattingRoom.fromJson(roomJson));
    });

    return chattingRooms;
  }
  
  Future getChattingRoomInfo(String myToken, String otherUserToken) async =>
      await userProvider.getChattingRoomInfo(myToken, otherUserToken);
}