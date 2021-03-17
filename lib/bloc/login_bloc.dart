import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/login_event.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/repository/login_repository.dart';
import 'package:flutter_chatting/repository/user_repository.dart';

import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState());

  final LoginRepository loginRepository = LoginRepository();
  final UserRepository userRepository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitEvent) {
      yield LoginInitState();
    } else if (event is LoginProgressEvent) {
      yield LoginLoadingState();
      bool isLogin = false;
      try {
        isLogin = await _signIn(event);
        print('LoginEndState $event');
        yield LoginEndState(isLogin);
      } catch(e) {
        print('LoginErrorState $e');
        yield LoginErrorState();
      }
    } else if (event is SignUpEvent) {
      if (event.signUp == SignUp.changePage) yield ChangePageState();
      else if (event.signUp == SignUp.signUp) {
        await _signUp(event);
        yield LoginInitState();
      }
    }
  }

  Future<bool> _signIn(LoginProgressEvent event) async => await loginRepository.signIn(event.id, event.password);

  Future _signUp(SignUpEvent event) async {
    final user = User(event.name, event.id, event.password);
    await loginRepository.signUp(user.id, user.password).then((bool isSignUp) {
      if(isSignUp) {
        final result = userRepository.registerUser(user.toMap);
        print('_signUp $result');
        return result;
      }
    });
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