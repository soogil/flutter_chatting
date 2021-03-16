import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/login_bloc.dart';


class SignInPageView extends StatelessWidget {

  final TextEditingController idTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) {
        if (state is LoginLoading) return Center(child: CircularProgressIndicator());
        else if (state is LoginEnd) {
          if(state.isLogin) {
            return Container(
              color: Colors.blue,
            );
          }
        }

          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _getIdField(),
                _getPasswordField(),
                _getLoginButton(context),
              ],
            ),
          );
      },
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
    return OutlineButton(
      onPressed: () {
        print('${idTextController.text} ${passwordTextController.text}');
        BlocProvider.of<LoginBloc>(context).add(LoginProgress(idTextController.text, passwordTextController.text));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Text(
          '로그인'
      ),
    );
  }
}
