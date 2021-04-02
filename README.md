### flutter_chatting

Firebase와 bloc을 사용해 Firebase에 등록된 사람들끼리 채팅할 수 있게 해주는 앱을 만들어보는 중입니다. 

(MVVM => Model: repository, provider, View: widget/screen, ViewModel: bloc)

Firebase message, realtime database 사용

### db table 

- chaanlToknen - fcmToken - chattingRoomId List
- messageByRoomId - chattingRoomId List - Message(fcmToken, message, messageTime, userName) List
- rooms - roomId List - roomInfo(fcmToken, message, messageTime, roomUsers, userName)
- users - user List - User(email, fcmToken, password, userName)

