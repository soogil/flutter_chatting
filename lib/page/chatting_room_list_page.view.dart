import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/service/route_service.dart';


class ChattingRoomListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChattingBloc>(context).add(ChattingInitEvent());

    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(context),
      floatingActionButton: _getUserListButton(context),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('ChatRoomList'),
    );
  }

  Widget _getBody(BuildContext context) {
    return BlocBuilder<ChattingBloc, ChattingInitState>(
        builder: (context, state) {
          return _getChattingRoomList(context, state.items);
        });
  }

  _getChattingRoomList(BuildContext contextList, List<User> users) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (context, index) => _getChattingRoomItem(context, users[index]),
      separatorBuilder: (context, index) => SizedBox(height: 20,),
    );
  }

  _getChattingRoomItem(BuildContext context, User user) {
    print(user.toMap);
    return FlatButton(
      onPressed: () => RouteService.routeSlidePage(context, routeName: RouteNames.chattingScreenPage),
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
                )
              ),
            ]
        ),
      ),
    );
  }

  Widget _getUserListButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => RouteService.routeSlidePage(context, routeName: RouteNames.userListPage),
      child: Icon(Icons.search),
    );
  }
}
