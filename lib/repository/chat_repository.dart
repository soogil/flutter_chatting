import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/provider/chat_provider.dart';

class ChatRepository {
  final ChatProvider chatProvider = ChatProvider();

  Future getMessageList(String roomId) async {
    return chatProvider.getMessageList(roomId);
  }

  Future sendMessage(ChattingRoom room) async {
    print('sendMessage 1111');

    print('sendMessage ${room.roomId}, ${room.message.toJson}');

    await chatProvider.updateRoom(room).then((_) {
      chatProvider.sendMessage(room.roomId, room.message);
    });
  }
}