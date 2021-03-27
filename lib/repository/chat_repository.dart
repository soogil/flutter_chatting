import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/room.dart';
import 'package:flutter_chatting/provider/chat_provider.dart';

class ChatRepository {
  final ChatProvider chatProvider = ChatProvider();

  Future<List<Message>> getMessageList(String roomId) async {
    final Map snapShot = await chatProvider.getMessageList(roomId);
    final List<Message> messages = [];

    if (snapShot != null) {
      messages.addAll(List.generate(snapShot.values.toList().length,
              (index) => Message.fromJson(snapShot.values.toList()[index])));
    }
    return messages;
  }

  Future sendMessage(ChattingRoom room) async {
    print('sendMessage 1111');

    print('sendMessage ${room.roomId}, ${room.message.toJson}');

    await chatProvider.updateRoom(room).then((_) {
      chatProvider.sendMessage(room.roomId, room.message);
    });
  }
}