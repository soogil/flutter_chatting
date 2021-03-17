
import 'package:equatable/equatable.dart';

class User extends Equatable {
  User(this.name, this.id, this.password);

  final String id;
  final String password;
  final String name;

  Map<String, dynamic> get toMap => {
    'id': id,
    'password': password,
    'name': name,
  };

  @override
  List<Object> get props => [id, name];
}