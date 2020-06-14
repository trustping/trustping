import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

class UOTherapyPage1 extends StatefulWidget {
  @override
  _UOTherapyPage1State createState() => _UOTherapyPage1State();
}

class _UOTherapyPage1State extends State<UOTherapyPage1> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Chemotherapie",
    "Immuntherapie",
    "Operation",
    "Hormontherapie",
    "Strahlentherapie",
    "Psychotherapie",
    "Komplementäre Medizin",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Therapie",
        body: "Welche Therapien hast du gemacht, machst Du, oder sind geplant?",
        header: TPProgressIndicator(
          i: 1,
          n: 2,
          section: "Therapie",
          colors: Style.blues,
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
                ExtendedNavigator.of(context).pushNamed(Routes.uoTherapyPage2);
              }
            },
            onSkip: () =>
                ExtendedNavigator.of(context).pushNamed(Routes.uoTherapyPage2),
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
          colors: Style.blues,
          onSelected: (bool selected) {
            setState(() =>
                selected ? _selected.add(option) : _selected.remove(option));
          },
        );
      }).toList(),
    );
  }
}

class UOTherapyPage2 extends StatefulWidget {
  @override
  _UOTherapyPage2State createState() => _UOTherapyPage2State();
}

class _UOTherapyPage2State extends State<UOTherapyPage2> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Erschöpfung",
    "Immuntherapie",
    "Operation",
    "Hormontherapie",
    "Strahlentherapie",
    "Psychotherapie",
    "Komplementäre Medizin",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Nebenwirkungen",
        body: "TODO fix buildOnboaringContent to not require text",
        header: TPProgressIndicator(
          i: 2,
          n: 2,
          section: "Therapie",
          colors: Style.blues,
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
                    .pushNamed(Routes.uoLivingSituationPage1);
              }
            },
            onSkip: () => ExtendedNavigator.of(context)
                .pushNamed(Routes.uoLivingSituationPage1),
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
          colors: Style.blues,
          onSelected: (bool selected) {
            setState(() =>
                selected ? _selected.add(option) : _selected.remove(option));
          },
        );
      }).toList(),
    );
  }
}
