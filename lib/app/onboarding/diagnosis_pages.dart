import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/constants/strings.dart';
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
          color: Style.accentColor2,
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
          vspace16,
          RaisedButton(
            child: Text(Strings.next),
            color: Style.accentColor1,
            onPressed: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
              }
              ExtendedNavigator.of(context)
                  .popAndPushNamed(Routes.uoDiagnosisPage2);
            },
          )
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
          color: Style.accentColor2,
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
          vspace16,
          RaisedButton(
            child: Text(Strings.next),
            color: Style.accentColor1,
            onPressed: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
              }
              ExtendedNavigator.of(context)
                  .popAndPushNamed(Routes.uoDiagnosisPage2);
            },
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
