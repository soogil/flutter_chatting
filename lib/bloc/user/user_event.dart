import 'package:flutter_chatting/model/user.dart';

abstract class UserEvent {}
class UserListEvent extends UserEvent {}
class GetChattingRoomEvent extends UserEvent {
  GetChattingRoomEvent(this._myInfo, this._otherUserInfo);
  final User _myInfo;
  final User _otherUserInfo;

  List<RoomUser> get users => [_myInfo, _otherUserInfo];
  String get myToken => _myInfo.fcmToken;
  String get otherUserToken => _otherUserInfo.fcmToken;
}