import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

// =============================================================================
// Page 1
class UODiagnosisPage1 extends StatefulWidget {
  @override
  _UODiagnosisPage1State createState() => _UODiagnosisPage1State();
}

class _UODiagnosisPage1State extends State<UODiagnosisPage1> {
  final key = GlobalKey<FormState>();

  final List<String> _options = ["Keine Angabe", "Brustkrebs", "Andere"];
  String _cancerType = "Keine Angabe";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Diagnose",
        body: "Welchen Tumor hast/hattest Du?",
        header: TPProgressIndicator(
          i: 1,
          n: 3,
          section: "Diagnose",
          colors: Style.reds,
        ),
        form: _buildForm(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _cancerType,
            onChanged: (String value) {
              setState(() => _cancerType = value);
            },
            onSaved: (String value) {
              setState(() => _cancerType = value);
            },
            items: _options.map((e) {
              return DropdownMenuItem<String>(value: e, child: Text(e));
            }).toList(),
            isExpanded: true,
          ),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .pushNamed(Routes.uoDiagnosisPage3);
              }
            },
            onSkip: () => ExtendedNavigator.of(context)
                .pushNamed(Routes.uoDiagnosisPage3),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}

// =============================================================================
// Page 2 --> gone

// =============================================================================
// Page 3
class UODiagnosisPage3 extends StatefulWidget {
  @override
  _UODiagnosisPage3State createState() => _UODiagnosisPage3State();
}

class _UODiagnosisPage3State extends State<UODiagnosisPage3> {
  final key = GlobalKey<FormState>();

  final Set<String> _options = Set.from([
    "Vorstufe / DCIS",
    "Hormonsensitiv",
    "HER2+",
    "Triple negative+",
    "Fortgeschritten / Metastasen",
  ]);
  Set<String> _selected = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Diagnose / Eigenschaften ",
        body: "",
        header: TPProgressIndicator(
          i: 2,
          n: 3,
          section: "Diagnose",
          colors: Style.reds,
        ),
        form: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .pushNamed(Routes.uoDiagnosisPage4);
              }
            },
            onSkip: () => ExtendedNavigator.of(context)
                .pushNamed(Routes.uoDiagnosisPage4),
          ),
        ],
      ),
    );
  }

  Widget _buildChips() {
    // TODO split item on sep. lines
    // TODO talk to anke about logic
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map(
        (option) {
          return TPFilterChip(
            label: option,
            selected: _selected.contains(option),
            onSelected: (bool selected) {
              setState(() {
                selected ? _selected.add(option) : _selected.remove(option);
              });
            },
            colors: Style.reds,
          );
        },
      ).toList(),
    );
  }
}

// =============================================================================
// Page 4
class UODiagnosisPage4 extends StatefulWidget {
  @override
  _UODiagnosisPage4State createState() => _UODiagnosisPage4State();
}

class _UODiagnosisPage4State extends State<UODiagnosisPage4> {
  final key = GlobalKey<FormState>();

  final List<String> _options = [
    "Diagnose gerade bekommen",
    "in Behandlung",
    "Rezidiv",
    "Akutbehandlung abgeschlossen",
    "in Dauerbehandlung",
    "Leben nach Krebs (Survivorship)",
  ];
  Set<String> _selected = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Krankheitsphase",
        body: "Was trifft am ehesten auf dich zu?",
        header: TPProgressIndicator(
          i: 3,
          n: 3,
          section: "Diagnose",
          colors: Style.reds,
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
        children: <Widget>[
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context).pushNamed(Routes.uoTherapyPage1);
              }
            },
            onSkip: () =>
                ExtendedNavigator.of(context).pushNamed(Routes.uoTherapyPage1),
          ),
        ],
      ),
    );
  }

  Widget _buildChips() {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map(
        (option) {
          return TPFilterChip(
            label: option,
            selected: _selected.contains(option),
            onSelected: (bool selected) {
              setState(() {
                selected ? _selected.add(option) : _selected.remove(option);
              });
            },
            colors: Style.reds,
          );
        },
      ).toList(),
    );
  }
}
