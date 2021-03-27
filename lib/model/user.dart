import 'package:equatable/equatable.dart';

class User extends BaseModel {
  User({this.name, this.email, this.password, this.fcmToken});

  User.fromJson(Map json) :
        email = json['email'],
        password = json['password'],
        name = json['name'],
        fcmToken = json['fcmToken'];

  final String email;
  final String password;
  final String name;
  final String fcmToken;

  Map<String, dynamic> get toJson => {
    'email': email,
    'password': password,
    'name': name,
    'fcmToken': fcmToken,
  };

  @override
  List<Object> get props => [email, name];
}

abstract class BaseModel extends Equatable {
  @override
  List<Object> get props => [];
}