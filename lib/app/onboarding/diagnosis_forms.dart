import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/theme.dart';

// =============================================================================
// Page 1
class DiagnosisCancerForm extends StatefulWidget {
  final Function onNext;
  const DiagnosisCancerForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _DiagnosisCancerFormState createState() => _DiagnosisCancerFormState();
}

class _DiagnosisCancerFormState extends State<DiagnosisCancerForm> {
  final key = GlobalKey<FormState>();

  final List<String> _options = ["Keine Angabe", "Brustkrebs", "Andere"];
  String _cancerType = "Keine Angabe";

  @override
  Widget build(BuildContext context) {
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
                widget.onNext();
              }
            },
            onSkip: () => widget.onNext(),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}

// =============================================================================
// Page 3
class DiagnosisPropertiesForm extends StatefulWidget {
  final Function onNext;
  const DiagnosisPropertiesForm({Key key, @required this.onNext})
      : super(key: key);

  @override
  _DiagnosisPropertiesFormState createState() =>
      _DiagnosisPropertiesFormState();
}

class _DiagnosisPropertiesFormState extends State<DiagnosisPropertiesForm> {
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
                widget.onNext();
              }
            },
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }

  Widget _buildChips() {
    // TODO extract logic into class independent function
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
class DiagnosisPhaseForm extends StatefulWidget {
  final Function onNext;
  const DiagnosisPhaseForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _DiagnosisPhaseFormState createState() => _DiagnosisPhaseFormState();
}

class _DiagnosisPhaseFormState extends State<DiagnosisPhaseForm> {
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
                widget.onNext();
              }
            },
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }

  Widget _buildChips() {
    // TODO extract logic into class independent function
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
