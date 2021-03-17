import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/login_bloc.dart';
import 'package:flutter_chatting/bloc/login_event.dart';

class SignUpView extends StatelessWidget {
  
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController idTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getNameField(),
            SizedBox(height: 10),
            _getIdField(),
            SizedBox(height: 10),
            _getPasswordField(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getRegisterButton(context),
                _getLoginButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }
 
  Widget _getNameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: nameTextController,
      maxLength: 10,
      validator: (value) {
        if(value.isEmpty) {
          return '이름을 입력해주세요.';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'name',
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

  Widget _getRegisterButton(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        print('${idTextController.text} ${passwordTextController.text}');
        BlocProvider.of<LoginBloc>(context).add(SignUpEvent(
            SignUp.signUp,
            name: nameTextController.text,
            id: idTextController.text,
            password: passwordTextController.text
        ));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Text('가입'),
    );
  }

  _getLoginButton(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(LoginInitEvent());
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Text('로그인 화면으로'),
    );
  }
}
