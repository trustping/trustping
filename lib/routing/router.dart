import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:trust_ping_app/app/home/main_page.dart';
import 'package:trust_ping_app/app/home/ping_page.dart';
import 'package:trust_ping_app/app/landing_page.dart';
import 'package:trust_ping_app/app/compose_ping_page.dart';
import 'package:trust_ping_app/app/home/account/account_page.dart';
import 'package:trust_ping_app/app/home/chat_page.dart';
import 'package:trust_ping_app/app/introduction_page.dart';
import 'package:trust_ping_app/app/onboarding/onboarding_main_page.dart';
import 'package:trust_ping_app/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:trust_ping_app/app/user_profile_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LandingPage authWidget;

  @MaterialRoute(fullscreenDialog: true)
  EmailPasswordSignInPageBuilder emailPasswordSignInPageBuilder;

  @MaterialRoute(fullscreenDialog: false)
  MainPage mainPage;

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

  @MaterialRoute()
  PingPage pingPage;

  // Onboarding screens
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    durationInMilliseconds: 300,
  )
  OnboardingMainPage uoNamePage;
}
