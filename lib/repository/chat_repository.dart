import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/model/chatting_room.dart';
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
    messages.sort((a, b) => b.messageTime.compareTo(a.messageTime));

    return messages;
  }

  Future sendMessage(ChattingRoom room, Message msg) async {
    room.message = msg.message;
    room.messageTime = msg.messageTime;
    await chatProvider.updateRoom(room).then((_) {
      chatProvider.sendMessage(room.roomId, msg);
    });
  }
}