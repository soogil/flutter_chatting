import 'package:flutter/material.dart';
import 'package:flutter_chatting/page/chatting_room_list_page.view.dart';
import 'package:flutter_chatting/page/chatting_screen_page.view.dart';

class RouteService {

  Route<dynamic> route(RouteSettings settings) {
     switch(settings.name) {
       case RouteNames.chattingListPage:
         return PageRouteSlider(page: ChattingRoomListPage());
       case RouteNames.chattingRoomPage:
         return PageRouteSlider(page: ChattingScreenPageView());
     }
  }

  static void routeSlidePage(BuildContext context) {
    // route();
  }

  static routePage() {

  }
}

class PageRouteSlider extends PageRouteBuilder {
  PageRouteSlider({
    @required Widget page,
    Duration transitionDuration: const Duration(milliseconds: 400),
    RouteSettings settings,
  }) : super(
      pageBuilder: (_, Animation<double> animation, __,) => page,
      transitionDuration: transitionDuration,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) => SlideTransition(
        child: child,
        position: new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
      ),
      settings: settings
  );
}

class RouteNames {
  static const String initPage = '/';
  static const String chattingRoomPage = '/page/chatRoom';
  static const String chattingListPage = '/page/chatList';
}