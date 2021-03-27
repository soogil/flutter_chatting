import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_event.dart';
import 'package:flutter_chatting/bloc/chatting/chatting_state.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/widget/bubble.dart';


class ChattingScreenPageView extends StatelessWidget {
  ChattingScreenPageView(this.room);

  final ChattingRoom room;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
    return BlocBuilder<ChattingBloc, ChattingInitState>(
      builder: (context, state) {

        return Expanded(
          child: Container(
            child: ListView.separated(
              reverse: true,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Bubble(
                  message: 'aksjdfklsajfk민ㅇ러ㅣ만어리ㅏㅁ넝리ㅏㄴ머라ㅣㄴ머라ㅣㅁ넝리ㅏㅇㄴ멍리ㅏㅁ너리ALSDJFLASJFLKAFLKAFㅁ아니럼니ㅏ러니ㅏㅁlssdfsdfsdfsfsfsdfafd',
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
                  BlocProvider.of<ChattingBloc>(context).add(SendChattingEvent(_setMessage()));
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
