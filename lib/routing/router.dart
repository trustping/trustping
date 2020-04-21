import 'package:auto_route/auto_route_annotations.dart';
import 'package:trust_ping_app/app/auth_widget.dart';
import 'package:trust_ping_app/app/home/account/account_page.dart';
import 'package:trust_ping_app/app/home/chat_page.dart';
import 'package:trust_ping_app/app/home/chats_page.dart';
import 'package:trust_ping_app/app/introduction_page.dart';
import 'package:trust_ping_app/app/sign_in/email_password/email_password_sign_in_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  AuthWidget authWidget;

  @MaterialRoute(fullscreenDialog: true)
  EmailPasswordSignInPageBuilder emailPasswordSignInPageBuilder;

  @MaterialRoute(fullscreenDialog: false)
  ChatsPage chatsPage;

  @MaterialRoute(fullscreenDialog: false)
  ChatPage chatPage;

  @MaterialRoute(fullscreenDialog: false)
  AccountPage accountPage;

  @MaterialRoute(fullscreenDialog: false)
  IntroductionPage introductionPage;
}
