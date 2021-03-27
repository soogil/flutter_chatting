import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_event.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_state.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/widget/bubble.dart';


class ChattingScreenPageView extends StatelessWidget {
  ChattingScreenPageView(this.room);

  final ChattingRoom room;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChattingScreenBloc>(context).add(ChattingScreenInitEvent(room.roomId));

    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(context),
    );
  }

  Widget _getAppBar() {
    return AppBar();
  }

  Widget _getBody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _getChattingList(),
          _getInputChat(context),
        ],
      ),
    );
  }

  Widget _getChattingList() {
    return BlocBuilder<ChattingScreenBloc, ChattingScreenState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            child: ListView.separated(
              reverse: true,
              shrinkWrap: true,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                return Bubble(
                  message: state.messages[index].msg,
                  messageTime: DateTime.now(),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 10),
            ),
          ),
        );
      },
    );
  }

  Widget _getInputChat(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                  controller: messageController,
                )
            ),
            FlatButton(
              onPressed: () {
                if(messageController.text != null)
                  BlocProvider.of<ChattingScreenBloc>(context).add(SendMessageEvent(_setMessage()));
              },
              child: Icon(Icons.send),
            ),
          ],
        )
    );
  }

  ChattingRoom _setMessage() {
    room.message.type = Type.right;
    room.message.msg = messageController.text;
    room.message.time = DateTime.now().microsecondsSinceEpoch;
    return room;
  }
}
