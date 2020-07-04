import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

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
// Page 2
class UODiagnosisPage2 extends StatefulWidget {
  @override
  _UODiagnosisPage2State createState() => _UODiagnosisPage2State();
}

class _UODiagnosisPage2State extends State<UODiagnosisPage2> {
  final key = GlobalKey<FormState>();

  final List<String> _options = ["Keine Angabe", "TODO 1", "TODO 2"];
  String _diagnosis = "Keine Angabe";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Wie lautet deine Diagnose?",
        body:
            "lorem Lorem proident ullamco ex anim est ipsum ad. Irure dolore qui ex laborum.",
        header: TPProgressIndicator(
          i: 2,
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
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _diagnosis,
            onChanged: (String value) {
              setState(() => _diagnosis = value);
            },
            onSaved: (String value) {
              setState(() => _diagnosis = value);
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

enum _DiagnosisPhase {
  na,
  phase1,
  phase2,
  phase3,
  phase4,
  phase5,
  phase6,
  phase7,
}
const List<String> _diagnosisTexts = [
  "Keine Angabe",
  "Diagnose gerade bekommen",
  "In Behandlung",
  "Akutbehandlung abgeschlossen",
  "Ich habe ein Rezidiv",
  "In Dauerbehandlung",
  "Leben nach Krebs (Survivorship)",
  "Nichts davon trifft auf mich zu",
];

class _UODiagnosisPage4State extends State<UODiagnosisPage4> {
  final key = GlobalKey<FormState>();

  String _selected = "";

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
          DropdownButtonFormField<String>(
            onChanged: (value) {
              setState(() {
                _selected = value;
              });
            },
            items: List<DropdownMenuItem<String>>.generate(
              _diagnosisTexts.length,
              (i) {
                return DropdownMenuItem<String>(
                  child: Text(_diagnosisTexts[i]),
                  value: _diagnosisTexts[i],
                );
              },
            ),
          ),
          // _buildRadioTile(_diagnosisTexts[0], _DiagnosisPhase.na),
          // _buildRadioTile(_diagnosisTexts[1], _DiagnosisPhase.phase1),
          // _buildRadioTile(_diagnosisTexts[2], _DiagnosisPhase.phase2),
          // _buildRadioTile(_diagnosisTexts[3], _DiagnosisPhase.phase3),
          // _buildRadioTile(_diagnosisTexts[4], _DiagnosisPhase.phase4),
          // _buildRadioTile(_diagnosisTexts[5], _DiagnosisPhase.phase5),
          // _buildRadioTile(_diagnosisTexts[6], _DiagnosisPhase.phase6),
          // _buildRadioTile(_diagnosisTexts[7], _DiagnosisPhase.phase7),
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

  // RadioListTile<_DiagnosisPhase> _buildRadioTile(
  //     String text, _DiagnosisPhase value) {
  //       return
  //   return RadioListTile(
  //     title: Style.tiny(text),
  //     value: value,
  //     groupValue: _selected,
  //     onChanged: (value) => setState(() => _selected = value),
  //     activeColor: Style.red,
  //     // dense: true,
  //     controlAffinity: ListTileControlAffinity.trailing,
  //   );
  // }
}
