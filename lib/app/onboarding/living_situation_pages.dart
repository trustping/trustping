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
    "Pentioniert",
    "Schwanger",
    "Mit Familie",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Situation",
        body:
            "Erzähl uns noch etwas von Dir. Das hilft uns, die passenden Gesprächspartner für Dich zu finden.",
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
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
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
    "Yoga/Meditation",
    "Entspanniung",
    "Ernährung",
    "Wellness",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Interessen",
        body:
            "Was sind Deine Hobbies oder sind Themen, mit denen Du Dich im Zusammenhang mit Deiner Erkrankung beschäftigst oder beschäftigen möchtest?",
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
            buttonText: Strings.ok,
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
      children: _options.map((option) {
        return Container(
          child: FilterChip(
            label: Text(option),
            selected: _selected.contains(option),
            selectedColor: Style.yellow,
            backgroundColor: Style.yellow50,
            showCheckmark: false,
            onSelected: (bool selected) {
              setState(() =>
                  selected ? _selected.add(option) : _selected.remove(option));
            },
          ),
          padding: EdgeInsets.only(right: 4),
        );
      }).toList(),
    );
  }
}
