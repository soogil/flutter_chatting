import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
import 'package:flutter_chatting/model/notifycation.dart';
import 'package:flutter_chatting/model/user.dart';
import 'package:flutter_chatting/service/push_service.dart';
import 'package:flutter_chatting/service/route_service.dart';
import 'package:flutter_chatting/service/stream_provider.dart';


class ChattingRoomListPage extends StatefulWidget {
  const ChattingRoomListPage();

  @override
  _ChattingRoomListPageState createState() => _ChattingRoomListPageState();
}

class _ChattingRoomListPageState extends State<ChattingRoomListPage> with StreamProvider {

  final GlobalKey _scaffoldKey = GlobalKey();

  void _chattingRoomInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ChattingBloc>(_scaffoldKey.currentContext).add(ChattingInitEvent());

      final pushMessage = MessageStream.instance.subScribeOnMessage().listen((data) {
        final pushMessage = PushMessage.fromJson(Map<String, dynamic>.from(data));
        BlocProvider.of<ChattingBloc>(_scaffoldKey.currentContext).add(
            PushUpdateEvent(pushMessage.chattingRoom));
      });
      addStream('pushMessage', pushMessage);
    });
  }


  @override
  void initState() {
    _chattingRoomInit();
    super.initState();
  }

  @override
  void dispose() {
    removeStream('pushMessage');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

  _getChattingRoomList(BuildContext contextList, List<BaseModel> model) {
    return ListView.separated(
      itemCount: model.length,
      itemBuilder: (context, index) => _getChattingRoomItem(context, model[index]),
      separatorBuilder: (context, index) => SizedBox(height: 20,),
    );
  }

  _getChattingRoomItem(BuildContext context, ChattingRoom room) {
    return FlatButton(
      onPressed: () =>
          RouteService.routeSlidePage(
              context,
              routeName: RouteNames.chattingScreenPage,
              params: room.roomInfo).then((data) {

                if(data == null) return;

                print('routeSlidePage $data');
                BlocProvider.of<ChattingBloc>(context).add(
                    ChattingRoomsUpdateEvent(ChattingRoom.fromJson(data)));
              }),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.otherUserName,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                        room.lastMessage,
                        style: TextStyle(
                          fontSize: 13,
                        )
                    ),
                  ]
              ),
            ),
            Text(
              room.lastMessageTime,
            ),
          ],
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
