import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/living_situation_forms.dart';
import 'package:trust_ping_app/app/onboarding/user_onboarding_page.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/app/onboarding/diagnosis_forms.dart';
import 'package:trust_ping_app/app/onboarding/therapy_forms.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

// Pageviews for all the onboarding parts
class OnboardingMainPage extends StatefulWidget {
  @override
  _OnboardingMainPageState createState() => _OnboardingMainPageState();
}

class _OnboardingMainPageState extends State<OnboardingMainPage> {
  final PageController pageController = PageController();

  int currentPage = 0;
  int maxPages = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.tp)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
              itemBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return buildOnboardingView(
                      form: UserNameForm(onNext: nextPage),
                      context: context,
                      title: "Hallo!",
                      body: "Wie möchtest Du angesprochen werden?",
                      header: trustpingImage100,
                    );
                    break;

                  case 1:
                    return buildOnboardingView(
                      form: UserAgeForm(onNext: nextPage),
                      context: context,
                      title: "Alter",
                      body: "Was ist dein Geburtsjahr?",
                      header: trustpingImage100,
                    );
                    break;

                  case 2:
                    return buildOnboardingView(
                      form: DiagnosisCancerForm(onNext: nextPage),
                      context: context,
                      title: "Diagnose",
                      body: "Welchen Tumor hast/hattest Du?",
                      header: TPProgressIndicator(
                        i: 1,
                        n: 3,
                        section: "Diagnose",
                        colors: Style.reds,
                      ),
                    );
                    break;

                  case 3:
                    return buildOnboardingView(
                      form: DiagnosisPropertiesForm(onNext: nextPage),
                      context: context,
                      title: "Diagnose / Eigenschaften ",
                      body: "",
                      header: TPProgressIndicator(
                        i: 2,
                        n: 3,
                        section: "Diagnose",
                        colors: Style.reds,
                      ),
                    );
                    break;

                  case 4:
                    return buildOnboardingView(
                      form: DiagnosisPhaseForm(onNext: nextPage),
                      context: context,
                      title: "Krankheitsphase",
                      body: "Was trifft am ehesten auf dich zu?",
                      header: TPProgressIndicator(
                        i: 3,
                        n: 3,
                        section: "Diagnose",
                        colors: Style.reds,
                      ),
                    );
                    break;

                  case 5:
                    return buildOnboardingView(
                      form: TherapyTherapyForm(onNext: nextPage),
                      context: context,
                      title:
                          "Welche Therapien hast du gemacht, machst Du, oder sind geplant?",
                      body: "",
                      header: TPProgressIndicator(
                        i: 1,
                        n: 2,
                        section: "Therapie",
                        colors: Style.blues,
                      ),
                    );
                    break;

                  case 6:
                    return buildOnboardingView(
                      form: TherapySideEffectForm(onNext: nextPage),
                      context: context,
                      title: "Nebenwirkungen",
                      body:
                          "Verschiedene Effekte der Erkrankung und auch der Therapie sind ein Thema für viele Menschen. Wozu genau suchst du Austausch oder kannst vielleicht helfen?",
                      header: TPProgressIndicator(
                        i: 2,
                        n: 2,
                        section: "Therapie",
                        colors: Style.blues,
                      ),
                    );
                    break;

                  case 7:
                    return buildOnboardingView(
                      form: LivingSituationForm(onNext: nextPage),
                      context: context,
                      title: "Lebenssituation",
                      body:
                          "Erzähl uns noch etwas von Dir. Wenn Du bestimmte Fragen hast, können diese Infos helfen, schnell die richtigen Kontakte zu finden.",
                      header: TPProgressIndicator(
                        i: 1,
                        n: 2,
                        section: "Situation",
                        colors: Style.yellows,
                      ),
                    );
                    break;

                  case 8:
                    return buildOnboardingView(
                      form: LivingSituationInterestsForm(
                        onNext: () {
                          ExtendedNavigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                      ),
                      context: context,
                      title: "Interessen und Fragen",
                      body:
                          "Was sind wichtige Themen, mit denen Du Dich beschäftigst oder beschäftigen möchtest?",
                      header: TPProgressIndicator(
                        i: 2,
                        n: 2,
                        section: "Situation",
                        colors: Style.yellows,
                      ),
                    );
                    break;

                  default:
                    return Container(
                      child: Center(child: Text("We should not be here")),
                      color: Style.red,
                    );
                }
              },
              itemCount: maxPages,
            ),
          ),
        ],
      ),
    );
  }

  void previousPage() {
    currentPage = min(currentPage - 0, 0);
    pageController.animateToPage(
      currentPage,
      duration: Duration(milliseconds: 350),
      curve: Curves.linear,
    );
  }

  void nextPage() {
    currentPage = min(currentPage + 1, maxPages);
    pageController.animateToPage(
      currentPage,
      duration: Duration(milliseconds: 350),
      curve: Curves.linear,
    );
  }
}
