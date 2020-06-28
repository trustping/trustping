import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

class UOLivingSituationPage1 extends StatefulWidget {
  @override
  _UOLivingSituationPage1State createState() => _UOLivingSituationPage1State();
}

class _UOLivingSituationPage1State extends State<UOLivingSituationPage1> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Single",
    "In Partnerschaft/Verheiratet",
    "In Ausbildung/Studium",
    "Berufstätig",
    "Pensioniert",
    "Schwanger",
    "Mit Familie",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
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
        form: _buildForm(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .pushNamed(Routes.uoLivingSituationPage2);
              }
            },
            onSkip: () => ExtendedNavigator.of(context)
                .pushNamed(Routes.uoLivingSituationPage2),
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map((option) {
        return TPFilterChip(
          label: option,
          selected: _selected.contains(option),
          colors: Style.yellows,
          onSelected: (bool selected) {
            setState(() =>
                selected ? _selected.add(option) : _selected.remove(option));
          },
        );
      }).toList(),
    );
  }
}

class UOLivingSituationPage2 extends StatefulWidget {
  @override
  _UOLivingSituationPage2State createState() => _UOLivingSituationPage2State();
}

class _UOLivingSituationPage2State extends State<UOLivingSituationPage2> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Sport",
    "Yoga",
    "Meditation",
    "Entspannung",
    "Ernährung",
    "Job",
    "Selbsthilfe",
    "Reha",
    "Sozialrecht",
    "Politik",
    "Kultur",
    "Kosmetik",
    "Sexualität",
    "Nebenwirkungen",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
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
        form: _buildForm(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .popUntil((route) => route.isFirst);
              }
            },
            onNextButtonText: Strings.ok,
            onSkip: () => ExtendedNavigator.of(context)
                .popUntil((route) => route.isFirst),
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map((option) {
        return TPFilterChip(
          label: option,
          selected: _selected.contains(option),
          colors: Style.yellows,
          onSelected: (bool selected) {
            setState(() =>
                selected ? _selected.add(option) : _selected.remove(option));
          },
        );
      }).toList(),
    );
  }
}
