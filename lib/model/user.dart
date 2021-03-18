
import 'package:equatable/equatable.dart';

class User extends Equatable {
  User(this.name, this.email, this.password);

  User.fromJson(Map json) :
        email = json['email'],
        password = json['password'],
        name = json['name'];

  final String email;
  final String password;
  final String name;

  Map<String, dynamic> get toMap => {
    'email': email,
    'password': password,
    'name': name,
  };

  @override
  List<Object> get props => [email, name];
}