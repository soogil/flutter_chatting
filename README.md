### flutter_chatting

Firebase와 bloc을 사용해 Firebase에 등록된 사람들끼리 채팅할 수 있게 해주는 앱을 만들어보는 중입니다. 

(MVVM => Model: repository, provider, View: widget/screen, ViewModel: bloc)

Firebase message, realtime database 사용

### db table 

- chaanlToknen - fcmToken - chattingRoomId List
- messageByRoomId - chattingRoomId List - Message(fcmToken, message, messageTime, userName) List
- rooms - roomId List - roomInfo(fcmToken, message, messageTime, roomUsers, userName)
- users - user List - User(email, fcmToken, password, userName)


### TODO List
- ~user list 화면에서 채팅방을 처음 생성 후 채팅방 목록으로 왔을때 다시 호출해야됨~
- ~user list 화면에서 chatting 화면으로 넘어간뒤 채팅 후에 채팅방 목록으로 왔을때 업데이트~
- 새로운 메세지 badge 작업 및 read 
- 현재 fcm으로 되어있는 코드 추후에 soket으로 
