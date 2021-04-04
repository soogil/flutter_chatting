import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_event.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_state.dart';
import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/notifycation.dart';
import 'package:flutter_chatting/model/sign_in_user.dart';
import 'package:flutter_chatting/service/push_service.dart';
import 'package:flutter_chatting/service/stream_provider.dart';
import 'package:flutter_chatting/widget/bubble.dart';


class ChattingScreenPageView extends StatefulWidget {
  @override
  _ChattingScreenPageViewState createState() => _ChattingScreenPageViewState();
}

class _ChattingScreenPageViewState extends State<ChattingScreenPageView> with StreamProvider {
  final TextEditingController messageController = TextEditingController();

  void _chattingScreenInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ChattingScreenBloc>(context).add(ChattingScreenInitEvent());
      final screenMessage = MessageStream.instance.subScribeOnMessage().listen((data) {
        final pushMessage = PushMessage.fromJson(Map<String, dynamic>.from(data));
        BlocProvider.of<ChattingScreenBloc>(context).add(PushUpdateScreenEvent(pushMessage.messageUser));
      });
      addStream('screenMessage', screenMessage);
    });
  }

  @override
  void initState() {
    _chattingScreenInit();
    super.initState();
  }

  @override
  void dispose() {
    removeStream('screenMessage');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context,
            BlocProvider
                .of<ChattingScreenBloc>(context)
                .state.chattingRoomToJson);
        return true;
      },
      child: Scaffold(
        appBar: _getAppBar(),
        body: _getBody(context),
      ),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => _popScreen(),
      ),
    );
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

  _popScreen() {
    Navigator.pop(context,
        BlocProvider
            .of<ChattingScreenBloc>(context)
            .state.chattingRoomToJson);
  }
}
