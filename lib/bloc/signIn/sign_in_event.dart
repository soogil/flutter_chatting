import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent(this.id, this.password);
  final String id;
  final String password;
  @override
  List<Object> get props => [];
}

class SignInInitEvent extends SignInEvent {
  SignInInitEvent({String id, String password}) : super(id, password);
}

class SignInProgressEvent extends SignInEvent {
  SignInProgressEvent(String id, String password) : super(id, password);
}

enum SignUp {
  changePage,
  signUp,
}
class SignUpEvent extends SignInEvent{
  SignUpEvent(this.signUp, {
    this.name = '',
    String id = '',
    String password = '',
  }) : super(id, password);

  final SignUp signUp;
  final String name;
}