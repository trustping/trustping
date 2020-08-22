import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:trust_ping_app/app/home/page.dart';
import 'package:trust_ping_app/app/home/ping_page.dart';
import 'package:trust_ping_app/app/home/profile_tab.dart';
import 'package:trust_ping_app/app/landing_page.dart';
import 'package:trust_ping_app/app/home/ping_composer_page.dart';
import 'package:trust_ping_app/app/home/chat_page.dart';
import 'package:trust_ping_app/app/introduction_page.dart';
import 'package:trust_ping_app/app/onboarding/page.dart';
import 'package:trust_ping_app/app/sign_in/email_password/email_password_sign_in_page.dart';

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

  @MaterialRoute(fullscreenDialog: true)
  IntroductionPage introductionPage;

  @CustomRoute(
    fullscreenDialog: false,
    transitionsBuilder: TransitionsBuilders.zoomIn,
  )
  ComposePingPage composePingPage;

  @MaterialRoute()
  ComposePingSelectorPage composePingSelectorPage;

  @MaterialRoute()
  PingPage pingPage;

  @MaterialRoute()
  ProfileEditPage profileEditPage;

  // Onboarding screens
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    durationInMilliseconds: 300,
  )
  OnboardingMainPage uoNamePage;
}
