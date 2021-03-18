import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chat/chat_room_bloc.dart';
import 'package:flutter_chatting/bloc/chat/chat_room_event.dart';
import 'package:flutter_chatting/bloc/chat/chat_room_state.dart';
import 'package:flutter_chatting/model/user.dart';


class ChattingRoomListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatRoomBloc>(context).add(ChatRoomInitEvent());

    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(context),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('ChatRoomList'),
    );
  }

  Widget _getBody(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomInitState>(
        builder: (context, state) {
          return _getUserList(state.users);
        });
  }

  _getUserList(List<User> users) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (context, index) => _getUserItem(users[index]),
      separatorBuilder: (context, index) => SizedBox(height: 20,),
    );
  }

  _getUserItem(User user) {
    return FlatButton(
      onPressed: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 15),
              Text(user.email,
                style: TextStyle(
                  fontSize: 13,
                ),),
            ]
        ),
      ),
    );
  }
}
