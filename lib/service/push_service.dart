import 'package:firebase_messaging/firebase_messaging.dart';

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

  Future<String> get token async => _token ?? _getToken();
}
