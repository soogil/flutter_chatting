import 'package:flutter_chatting/model/message.dart';
import 'package:flutter_chatting/provider/chat_provider.dart';
import 'package:uuid/uuid.dart';

class ChatRepository {
  final ChatProvider chatProvider = ChatProvider();

  Future getMessageList(String roomId) async {

    return chatProvider.getMessageList(roomId);
  }

  Future sendMessage(String msg,{String roomId}) async {
    final message = Message(Type.right, msg, DateTime.now());
    roomId ??= Uuid().v4();
    final send = await chatProvider.sendMessage(roomId, message);
    print('sendMessage $send');
  }
}