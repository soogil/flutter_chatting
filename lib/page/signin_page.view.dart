import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/signIn/sign_in_bloc.dart';
import 'package:flutter_chatting/bloc/signIn/sign_in_event.dart';
import 'package:flutter_chatting/bloc/signIn/sign_in_state.dart';
import 'package:flutter_chatting/page/chatting_room_list_page.view.dart';
import 'package:flutter_chatting/view/sign-up.view.dart';


class SignInPage extends StatelessWidget {

  final TextEditingController idTextController = TextEditingController(text: 'zmfflrql5@naver.com');
  final TextEditingController passwordTextController = TextEditingController(text: 'soflau159!');
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppBar(),
      body: _getBody(context),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('Login'),
    );
  }

  Widget _getBody(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (_, state) {
        if (state is SignInLoadingState) return Center(child: CircularProgressIndicator());
        else if (state is SignInEndState && state.isLogin) {
          print('SignInEndState');
          _afterLayout(
            function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingRoomListPage()))
          );
        } else if (state is SignUpInitState) {
          return SignUpView();
        } else if(state is SignInErrorState) {
          _afterLayout(function: () => _popUpDialog(context));
        }

        return _getSignInView(context);
      },
    );
  }

  Widget _getSignInView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      alignment: Alignment.center,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getIdField(),
            SizedBox(height: 10),
            _getPasswordField(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getLoginButton(context),
                _getSignUpButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIdField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: idTextController,
      maxLength: 25,
      validator: (value) {
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return 'email 형식에 맞게 입력해주세요.';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'id',
      ),
    );
  }

  Widget _getPasswordField() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: passwordTextController,
        obscureText: true,
        validator: (value) {
          if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*()]{4,18}$').hasMatch(value)) {
            return '영문, 숫자, 특수문자(4~18자리)로 입력해주세요.';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        )
    );
  }

  Widget _getLoginButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (formKey.currentState.validate())
          BlocProvider.of<SignInBloc>(context).add(SignInProgressEvent(idTextController.text, passwordTextController.text));
        else
          _popUpDialog(context);
      },
      child: Text('로그인'),
    );
  }

  _getSignUpButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        BlocProvider.of<SignInBloc>(context).add(SignUpEvent(SignUp.changePage));
      },
      child: Text('가입'),
    );
  }

  _popUpDialog(BuildContext context, {String text = '아이디, 비밀번호를 확인해주세요.'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(text),
        actions: [FlatButton(onPressed: () => Navigator.pop(context), child: Text('확인'))],
      ),
    );
  }

  _afterLayout({Function function}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      function();
    });
  }
}
