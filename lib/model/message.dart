
enum Type {
  left,
  right,
}

class Message {
  Message(this.type, this.msg, this.time);

  Message.fromJson(Map json)
      : type = json['type'],
        msg = json['msg'],
        time = json['time'];

  final Type type;
  final String msg;
  final DateTime time;

  Map<String, dynamic> get toMap => {
      'type': type,
      'message': msg,
      'messageTime': time,
    };
}