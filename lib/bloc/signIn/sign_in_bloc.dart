import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/signIn/sign_in_event.dart';
import 'package:flutter_chatting/repository/sign_in_repository.dart';

import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitState());

  final SignInRepository loginRepository = SignInRepository();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    print('mapEventToState $event');

    if (event is SignInInitEvent) {
      yield SignInInitState();
    } else if (event is SignInProgressEvent) {
      yield SignInLoadingState();
      bool isLogin = await _signIn(event);
      print('mapEventToState Login $isLogin');
      if(isLogin)
        yield SignInEndState(isLogin);
      else
        yield SignInErrorState();
    } else if (event is SignUpEvent) {
      if (event.signUp == SignUp.changePage) yield SignUpInitState();
      else if (event.signUp == SignUp.signUp) {
        final isSignUp = await _signUp(event);

        if(isSignUp) {
          yield SignInInitState();
        }
      }
    }
  }

  Future<bool> _signIn(SignInProgressEvent event) async {
    try {
      return await loginRepository.signIn(event.id, event.password) != null;
    } catch (e) {
      print('SignIn Exception $e');
      return false;
    }
  }

  Future<bool> _signUp(SignUpEvent event) async {
    try {
      return await loginRepository.signUp(event.name, event.id, event.password);
    } catch(e) {
      print('SignUp Exception $e');
      return false;
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