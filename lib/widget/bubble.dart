import 'package:flutter/material.dart';
import 'package:flutter_chatting/model/message.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    @required this.message,
    this.isMineMessage = true,
  });

  final Message message;
  final bool isMineMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        left: isMineMessage ? 30 : 0,
        right: isMineMessage ? 0 : 30,
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: this.isMineMessage ? Radius.circular(10)
                : Radius.zero,
            topRight: this.isMineMessage ? Radius.zero
                : Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
      ),
      child: Column(
        children: [
          Text(
            message.message,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(lastMessageTime),
        ],
      ),
    );
  }

  String get lastMessageTime {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(message.messageTime);
    final String hour = '${dateTime.hour >= 12 ? '오후' : '오전'} ${dateTime.hour >= 13 ? dateTime.hour - 12 : dateTime.hour == 24 ? 0 : dateTime.hour}';
    final String minute = dateTime.minute.toString();
    return '$hour:$minute';
  }
}

// class BubbleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(500, 0);
//     path.lineTo(30, 30);
//     path.lineTo(0, 0);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }