import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/user/user_bloc.dart';
import 'package:flutter_chatting/bloc/user/user_event.dart';
import 'package:flutter_chatting/bloc/user/user_state.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/service/route_service.dart';


class UserListPageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(UserListEvent());

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
    return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is CreateChattingRoomState) {
            _afterLayoutFunction(
                function: () =>
                    RouteService.routeSlidePage(
                        context, routeName: RouteNames.chattingScreenPage,
                        params: RoomInfo(
                          roomId: state.roomId,
                          roomUsers: state.chattingRoomUsers,
                        ))
            );
          }

          return _getUserList(context, state.items);
        });
  }

  _getUserList(BuildContext contextList, List<BaseModel> models) {
    return ListView.separated(
      itemCount: models.length,
      itemBuilder: (context, index) => _getUserItem(context, models[index]),
      separatorBuilder: (context, index) => SizedBox(height: 20,),
    );
  }

  _getUserItem(BuildContext context, User user) {
    final myInfo = SignInUser().user;

    return FlatButton(
      onPressed: () =>
        BlocProvider.of<UserBloc>(context).add(GetChattingRoomEvent(user, myInfo)),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.userName,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 15),
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ]
        ),
      ),
    );
  }

  _afterLayoutFunction({@required Function function}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      function();
    });
  }
}
