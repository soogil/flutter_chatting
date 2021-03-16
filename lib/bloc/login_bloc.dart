import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/repository/login_repository.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}
class LoginLoading extends LoginState { }
class LoginEnd extends LoginState {
  LoginEnd(this.isLogin);

  final bool isLogin;

  @override
  List<Object> get props => [isLogin];
}


abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginProgress extends LoginEvent {
  LoginProgress(this.id, this.password);

  final String id;
  final String password;

  @override
  List<Object> get props => [id, password];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginRepository) : super(LoginInitState());

  final LoginRepository loginRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginProgress) {
      print('mapEventToState ${event.id} ${event.password}');
      yield LoginLoading();
      final user = await loginRepository.login(event.id, event.password);
      print('mapEventToState Login ${user}');
      yield LoginEnd(user != null);
    }
  }

  @override
  void onChange(Change change) {
    print('onChange $change');
    super.onChange(change);
  }

  @override
  void onTransition(Transition transition) {
    print('onTransition $transition');
    super.onTransition(transition);
  }

  @override
  void onEvent(event) {
    print('onEvent $event');
    super.onEvent(event);
  }
}