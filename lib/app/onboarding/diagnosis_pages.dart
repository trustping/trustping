import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
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
        title: "Krebstyp",
        subtitle:
            "lorem Lorem proident ullamco ex anim est ipsum ad. Irure dolore qui ex laborum. Laboris officia dolore do amet culpa dolore ut. Incididunt magna aliqua pariatur aliquip ex.",
        header: TPProgressIndicator(
          i: 1,
          n: 4,
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
                    .pushNamed(Routes.uoDiagnosisPage2);
              }
            },
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
        subtitle:
            "lorem Lorem proident ullamco ex anim est ipsum ad. Irure dolore qui ex laborum.",
        header: TPProgressIndicator(
          i: 2,
          n: 4,
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
    "Tripple negative+",
    "Fortgeschritten / Metastasen",
  ]);
  Set<String> _selected = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Eigenschaften / Diagnose",
        subtitle: "some text required.",
        header: TPProgressIndicator(
          i: 3,
          n: 4,
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
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  Widget _buildChips() {
    return Wrap(
      children: _options.map(
        (option) {
          return Container(
            padding: EdgeInsets.only(right: 4),
            child: FilterChip(
              label: Text(option),
              selected: _selected.contains(option),
              onSelected: (bool selected) {
                setState(() {
                  selected ? _selected.add(option) : _selected.remove(option);
                });
              },
              showCheckmark: false,
              selectedColor: Style.red,
              backgroundColor: Style.red50,
            ),
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

enum Phase { na, todo1, todo2 }

class _UODiagnosisPage4State extends State<UODiagnosisPage4> {
  final key = GlobalKey<FormState>();

  Phase _selected = Phase.na;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Krankheitsphase",
        subtitle: "Was trifft am ehesten auf dich zu?",
        header: TPProgressIndicator(
          i: 4,
          n: 4,
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
          _buildRadioTile("Keine Angabe", Phase.na),
          _buildRadioTile("TODO 1", Phase.todo1),
          _buildRadioTile("TODO 2", Phase.todo2),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context).pushNamed(Routes.uoTherapyPage1);
              }
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  RadioListTile<Phase> _buildRadioTile(String text, Phase value) {
    return RadioListTile(
      title: Text(text),
      value: value,
      groupValue: _selected,
      onChanged: (value) => setState(() => _selected = value),
      activeColor: Style.red,
      dense: true,
    );
  }
}
