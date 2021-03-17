
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginEndState extends LoginState {
  LoginEndState(this.isLogin);
  final bool isLogin;
}
class LoginErrorState extends LoginState{}

class SignUpState extends LoginState {
  SignUpState(this.isSignUp);
  final bool isSignUp;
}
class ChangePageState extends LoginState {}