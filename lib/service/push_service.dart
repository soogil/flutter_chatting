import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

const String serverKey = 'AAAAbyvG-lQ:APA91bHLBtH9J4l2k-D0egY2vgcERyKK9HCMO8Qdm2CYLdl7U2pOqw1XgKuwiPEGXVEyKtDx8fQaumn_6WsxpzAD0JaAxMoecj6Y6GBRuNGRifG1QckwXvjbPGai-CAk5aOMI8fCyVXV';
const String fcmMessageUrl = "https://fcm.googleapis.com/fcm/send";
const Duration timeoutDuration = const Duration(seconds: 15);

class PushService {
  static final PushService _instance = PushService._internal();

  factory PushService() {
    return _instance;
  }

  PushService._internal() {
    _configure();
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  String _token;

  _configure() {
    firebaseMessaging.configure(
      // FG 메세지 왔을때
      onMessage: (Map<String, dynamic> message) async {
        print(message);
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
    return await firebaseMessaging.getToken().then((token) {
      _token = token;
      return token;
    });
  }

  Future<bool> sendFcmMessage(String message, String fcmToken) async {
    try {
      final header = {
        "content-type": "application/json",
        "Authorization": "key=$serverKey",
      };
      final requestMessage = {
        "registration_ids" : fcmToken,
        "collapse_key" : "type_a",
        "notification" : {
          "title": 'NewTextTitle',
          "body" : message,
        }
      };
      // final requestMessage = {
      //   "notification": {
      //     "title": title,
      //     "text": message,
      //     "sound": "default",
      //     "color": "#990000",
      //   },
      //   "priority": "high",
      //   "to": "/topics/all",
      // };
      List<int> requestBodyData = [];
      dynamic requestBody;

      HttpClientRequest request = await HttpClient().openUrl('POST', Uri.parse(fcmMessageUrl));

      header.forEach((header, value) {
        request.headers.add(header, value);
      });

      requestBody = json.encode(requestMessage);
      requestBodyData = utf8.encode(requestBody);

      request.add(requestBodyData);

      HttpClientResponse response = await request.close().timeout(timeoutDuration);

      print('sendFcmMessage $response');
      return true;
    } catch (e) {
      print('sendFcmMessage Error $e');
      return false;
    }
  }

  Future<String> get token async => _token ?? _getToken();
}
