import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent(this.id, this.password);
  final String id;
  final String password;
  @override
  List<Object> get props => [];
}

class LoginInitEvent extends LoginEvent {
  LoginInitEvent({String id, String password}) : super(id, password);
}

class LoginProgressEvent extends LoginEvent {
  LoginProgressEvent(String id, String password) : super(id, password);
}

enum SignUp {
  changePage,
  signUp,
}
class SignUpEvent extends LoginEvent{
  SignUpEvent(this.signUp, {
    this.name = '',
    String id = '',
    String password = '',
  }) : super(id, password);

  final SignUp signUp;
  final String name;
}