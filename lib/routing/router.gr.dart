// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:trust_ping_app/app/auth_widget.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:trust_ping_app/app/home/chats_page.dart';
import 'package:trust_ping_app/app/home/chat_page.dart';
import 'package:trust_ping_app/app/home/models.dart';
import 'package:trust_ping_app/app/home/account/account_page.dart';

abstract class Routes {
  static const authWidget = '/';
  static const emailPasswordSignInPageBuilder =
      '/email-password-sign-in-page-builder';
  static const chatsPage = '/chats-page';
  static const chatPage = '/chat-page';
  static const accountPage = '/account-page';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.authWidget:
        if (hasInvalidArgs<AuthWidgetArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AuthWidgetArguments>(args);
        }
        final typedArgs = args as AuthWidgetArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => AuthWidget(
              key: typedArgs.key, userSnapshot: typedArgs.userSnapshot),
          settings: settings,
        );
      case Routes.emailPasswordSignInPageBuilder:
        if (hasInvalidArgs<EmailPasswordSignInPageBuilderArguments>(args)) {
          return misTypedArgsRoute<EmailPasswordSignInPageBuilderArguments>(
              args);
        }
        final typedArgs = args as EmailPasswordSignInPageBuilderArguments ??
            EmailPasswordSignInPageBuilderArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => EmailPasswordSignInPageBuilder(
              key: typedArgs.key, onSignedIn: typedArgs.onSignedIn),
          settings: settings,
          fullscreenDialog: true,
        );
      case Routes.chatsPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChatsPage(),
          settings: settings,
          fullscreenDialog: false,
        );
      case Routes.chatPage:
        if (hasInvalidArgs<ChatPageArguments>(args)) {
          return misTypedArgsRoute<ChatPageArguments>(args);
        }
        final typedArgs = args as ChatPageArguments ?? ChatPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChatPage(chat: typedArgs.chat),
          settings: settings,
          fullscreenDialog: false,
        );
      case Routes.accountPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AccountPage(),
          settings: settings,
          fullscreenDialog: false,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AuthWidget arguments holder class
class AuthWidgetArguments {
  final Key key;
  final AsyncSnapshot<User> userSnapshot;
  AuthWidgetArguments({this.key, @required this.userSnapshot});
}

//EmailPasswordSignInPageBuilder arguments holder class
class EmailPasswordSignInPageBuilderArguments {
  final Key key;
  final void Function() onSignedIn;
  EmailPasswordSignInPageBuilderArguments({this.key, this.onSignedIn});
}

//ChatPage arguments holder class
class ChatPageArguments {
  final Chat chat;
  ChatPageArguments({this.chat});
}
