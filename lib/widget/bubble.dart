import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    @required this.message,
    @required this.messageTime,
    this.isMineMessage = true,
  });

  final DateTime messageTime;
  final String message;
  final bool isMineMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
      child: Text(
        this.message,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class BubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(500, 0);
    path.lineTo(30, 30);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}