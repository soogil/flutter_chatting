import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/service/route_service.dart';


class UserListPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChattingBloc>(context).add(ChattingUserListEvent());

    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(context),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('UserList'),
    );
  }

  Widget _getBody(BuildContext context) {
    return BlocBuilder<ChattingBloc, ChattingInitState>(
        builder: (context, state) => _getUserList(context, state.items));
  }

  _getUserList(BuildContext contextList, List<User> users) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (context, index) => _getUserItem(context, users[index]),
      separatorBuilder: (context, index) => SizedBox(height: 20,),
    );
  }

  _getUserItem(BuildContext context, User user) {
    return FlatButton(
      onPressed: () =>
          RouteService.routeSlidePage(context, routeName: RouteNames.chattingScreenPage, params: user),
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
