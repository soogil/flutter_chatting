import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_event.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_state.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/notifycation.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/service/push_service.dart';
import 'package:flutter_chatting/widget/bubble.dart';


class ChattingScreenPageView extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChattingScreenBloc>(context).add(ChattingScreenInitEvent());
    MessageStream.instance.subscription.onData((data) {
      final pushMessage = PushMessage.fromJson(Map<String, dynamic>.from(data));
      BlocProvider.of<ChattingScreenBloc>(context).add(PushUpdateScreenEvent(pushMessage.messageUser));
    });

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
                  message: state.messages[index],
                  isMineMessage: state.messages[index].fcmToken == SignInUser().fcmToken,
                );
              },
              separatorBuilder: (context, index) => Divider(color: Colors.transparent,height: 10),
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
                if(messageController.text != null) {
                  BlocProvider.of<ChattingScreenBloc>(context).add(SendMessageEvent(_setMessage()));
                  messageController.clear();
                }
              },
              child: Icon(Icons.send),
            ),
          ],
        )
    );
  }

  Message _setMessage() => Message(
      userName: SignInUser().userName,
      fcmToken: SignInUser().fcmToken,
      message: messageController.text,
      messageTime: DateTime.now().microsecondsSinceEpoch,
    );
}
