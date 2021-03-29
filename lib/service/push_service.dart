import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

const String serverKey = 'AAAAbyvG-lQ:APA91bHLBtH9J4l2k-D0egY2vgcERyKK9HCMO8Qdm2CYLdl7U2pOqw1XgKuwiPEGXVEyKtDx8fQaumn_6WsxpzAD0JaAxMoecj6Y6GBRuNGRifG1QckwXvjbPGai-CAk5aOMI8fCyVXV';
const String fcmMessageUrl = "https://fcm.googleapis.com/fcm/send";
const Duration timeoutDuration = const Duration(seconds: 15);
const header = {
  "content-type": "application/json",
  "Authorization": "key=$serverKey",
};

class PushService {
  static final PushService _instance = PushService._internal();

  factory PushService() => _instance;

  PushService._internal() {
    _configure();
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  String _token;

  _configure() {
    firebaseMessaging.configure(
      // FG 메세지 왔을때
      onMessage: (Map<String, dynamic> message) async {
        MessageStream.instance.onMessage(message);
      },
      // 메세지 클릭해서 앱이 구동됐을때
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
      },
      // BG to FG로 전환됐을때
      onResume: (Map<String, dynamic> message) async {
        print(message);
      },
    );
  }

  Future<String> _getToken() async {
    return _token = await firebaseMessaging.getToken().then((token) => token);
  }

  Future<bool> sendFcmMessage(String message, String fcmToken, {Map<String, dynamic> data}) async {
    try {
      final Map<String, dynamic> chattingRoom = data != null ? {"chattingRoom": data} : {};
      final requestMessage = {
        "notification": {
          "body": "$message",
          "title": "새로운 메세지가 왔습니다."
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done",
          ...chattingRoom
        },
        "to": "$fcmToken"
      };

      List<int> requestBodyData = [];
      dynamic requestBody;

      HttpClientRequest request = await HttpClient().postUrl(Uri.parse(fcmMessageUrl));

      header.forEach((header, value) {
        request.headers.add(header, value);
      });

      requestBody = json.encode(requestMessage);
      requestBodyData = utf8.encode(requestBody);

      request.add(requestBodyData);

      HttpClientResponse response = await request.close().timeout(timeoutDuration);
      response.transform(utf8.decoder).listen((contents) {
        print('sendFcmMessage $contents');
      });
      return true;
    } catch (e) {
      print('sendFcmMessage Error $e');
      return false;
    }
  }

  Future<String> get token async => _token ?? _getToken();
}

class MessageStream {
  static final MessageStream instance = MessageStream._internal();
 
  factory MessageStream() => instance;

  MessageStream._internal() {
    _subscription = notificationsStream.listen((event) => event);
  }

  StreamController<dynamic> _messageStreamController = StreamController<dynamic>.broadcast();
  StreamSubscription _subscription;

  dynamic message;

  void onMessage(dynamic message) {
    this.message = message;
    print('onMessage $message');
    _messageStreamController.sink.add(message);
  }

  void dispose() {
    _subscription.cancel();
    _messageStreamController?.close();
  }

  StreamSubscription get subscription => _subscription;
  Stream<dynamic> get notificationsStream  => _messageStreamController.stream;
}