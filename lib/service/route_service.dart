import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_bloc.dart';
import 'package:flutter_chatting/bloc/chatting/screen/chatting_screen_state.dart';
import 'package:flutter_chatting/bloc/user/user_bloc.dart';
import 'package:flutter_chatting/page/chatting_room_list_page.view.dart';
import 'package:flutter_chatting/page/chatting_screen_page.view.dart';
import 'package:flutter_chatting/page/user_list_page.view.dart';

class RouteService {
  static Map<String, dynamic> _params = Map();

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.chattingListPage:
        return PageRouteSlider(page: ChattingRoomListPage());
      case RouteNames.chattingScreenPage:
        return PageRouteSlider(page: BlocProvider(
            create: (_) => ChattingScreenBloc(
                ChattingScreenInitState(room: _params[RouteNames.chattingScreenPage])),
            child: ChattingScreenPageView()
        ));
      case RouteNames.userListPage:
        return PageRouteSlider(
            page: BlocProvider(
                create: (_) => UserBloc(),
                child: UserListPageView()
            )
        );
    }
    return null;
  }

  static Future routeSlidePage(BuildContext context,{
    String routeName, dynamic params,
  }) async {
    _params[routeName] = params;
    return await Navigator.pushNamed(context, routeName);
  }

  static routePage() {

  }
}

class PageRouteSlider extends PageRouteBuilder {
  PageRouteSlider({
    @required Widget page,
    Duration transitionDuration: const Duration(milliseconds: 200),
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
  static const String chattingScreenPage = '/page/chatRoom';
  static const String chattingListPage = '/page/chatList';
  static const String userListPage = '/page/userList';
}