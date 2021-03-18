import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chat/chat_room_bloc.dart';
import 'package:flutter_chatting/bloc/signIn/sign_in_bloc.dart';
import 'package:flutter_chatting/page/signin_page.view.dart';

void main() {
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SignInBloc()),
            BlocProvider(create: (_) => ChatRoomBloc()),
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(),
    );
  }
}