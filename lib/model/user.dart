import 'package:equatable/equatable.dart';

class RoomUser extends BaseModel {
  RoomUser(this.userName, this.email, this.fcmToken);
  RoomUser.fromJson(Map json) :
        email = json['email'],
        userName = json['userName'],
        fcmToken = json['fcmToken'];
  final String email;
  final String userName;
  final String fcmToken;

  Map<String, dynamic> get toJson => {
    'email': email,
    'userName': userName,
    'fcmToken': fcmToken,
  };
  @override
  List<Object> get props => [email, userName, fcmToken];
}

class User extends RoomUser {
  User({
    String name,
    String email,
    String fcmToken,
    this.password
  }) : super(name, email, fcmToken);

  User.fromJson(Map json) :
        password = json['password'],
        super.fromJson(json);

  final String password;

  Map<String, dynamic> get toJson => {
    'password': password,
    ...super.toJson,
  };

  @override
  List<Object> get props => [password, super.props];
}

abstract class BaseModel extends Equatable {
  @override
  List<Object> get props => [];
}