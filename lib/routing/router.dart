import 'package:auto_route/auto_route_annotations.dart';
import 'package:trust_ping_app/app/landing_page.dart';
import 'package:trust_ping_app/app/compose_ping_page.dart';
import 'package:trust_ping_app/app/home/account/account_page.dart';
import 'package:trust_ping_app/app/home/chat_page.dart';
import 'package:trust_ping_app/app/home/chats_page.dart';
import 'package:trust_ping_app/app/introduction_page.dart';
import 'package:trust_ping_app/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:trust_ping_app/app/onboarding/user_onboarding_page.dart';
import 'package:trust_ping_app/app/user_profile_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LandingPage authWidget;

  @MaterialRoute(fullscreenDialog: true)
  EmailPasswordSignInPageBuilder emailPasswordSignInPageBuilder;

  @MaterialRoute(fullscreenDialog: false)
  ChatsPage chatsPage;

  @MaterialRoute(fullscreenDialog: false)
  ChatPage chatPage;

  @MaterialRoute(fullscreenDialog: false)
  AccountPage accountPage;

  @MaterialRoute(fullscreenDialog: true)
  IntroductionPage introductionPage;

  @MaterialRoute(fullscreenDialog: false)
  UserProfilePage userProfilePage;

  @MaterialRoute(fullscreenDialog: false)
  ComposePingPage composePingPage;

  // Onboarding screens
  @MaterialRoute(fullscreenDialog: true)
  UONameScreen uoNameScreen;

  @MaterialRoute(fullscreenDialog: true)
  UOAgeScreen uoAgeScreen;
}
