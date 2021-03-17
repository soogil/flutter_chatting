import 'package:flutter/material.dart';

class ChattingRoomListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('ChatRoomList'),
    );
  }

  Widget _getBody() {
    return Container();
  }
}
