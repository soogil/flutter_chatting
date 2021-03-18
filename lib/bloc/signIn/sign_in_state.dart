
import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitState extends SignInState {}
class SignInLoadingState extends SignInState {}
class SignInEndState extends SignInState {
  SignInEndState(this.isLogin);
  final bool isLogin;
}
class SignInErrorState extends SignInState{}

class SignUpState extends SignInState {
  SignUpState(this.isSignUp);
  final bool isSignUp;
}
class SignUpInitState extends SignInState {}