import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_bloc.dart';
import 'package:flutter_chatting/bloc/signIn/sign_in_bloc.dart';
import 'package:flutter_chatting/bloc/user/user_bloc.dart';
import 'package:flutter_chatting/page/signin_page.view.dart';
import 'package:flutter_chatting/service/push_service.dart';
import 'package:flutter_chatting/service/route_service.dart';

void main() {
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SignInBloc()),
            BlocProvider(create: (_) => ChattingBloc(ChattingInitState())),
            BlocProvider(create: (_) => UserBloc()),
            BlocProvider(create: (_) => ChattingScreenBloc())
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getToken();

    return MaterialApp(
      onGenerateRoute: RouteService.routes,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(),
    );
  }

  _getToken() async => await PushService().token;
}