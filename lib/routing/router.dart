import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:trust_ping_app/app/landing_page.dart';
import 'package:trust_ping_app/app/compose_ping_page.dart';
import 'package:trust_ping_app/app/home/account/account_page.dart';
import 'package:trust_ping_app/app/home/chat_page.dart';
import 'package:trust_ping_app/app/home/chats_page.dart';
import 'package:trust_ping_app/app/introduction_page.dart';
import 'package:trust_ping_app/app/onboarding/diagnosis_pages.dart';
import 'package:trust_ping_app/app/onboarding/living_situation_pages.dart';
import 'package:trust_ping_app/app/onboarding/therapy_pages.dart';
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
  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UONamePage uoNamePage;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UOAgePage uoAgePage;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UODiagnosisPage1 uoDiagnosisPage1;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UODiagnosisPage2 uoDiagnosisPage2;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UODiagnosisPage3 uoDiagnosisPage3;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UODiagnosisPage4 uoDiagnosisPage4;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UOTherapyPage1 uoTherapyPage1;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UOTherapyPage2 uoTherapyPage2;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UOLivingSituationPage1 uoLivingSituationPage1;

  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 300)
  UOLivingSituationPage2 uoLivingSituationPage2;
}
