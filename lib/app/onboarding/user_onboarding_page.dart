import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

final Widget _logoHeader = SizedBox(
  child: Image.asset("assets/images/boxes.png", height: 100),
  height: 100,
);

class UONameScreen extends StatefulWidget {
  @override
  _UONameScreenState createState() => _UONameScreenState();
}

class _UONameScreenState extends State<UONameScreen> {
  final key = GlobalKey<FormState>();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Hallo!",
        subtitle: "Wie möchtest Du angesprochen werden?",
        header: _logoHeader,
        form: _buildForm(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            initialValue: _name,
            decoration: InputDecoration(labelText: "Dein Name"),
            validator: (value) => null,
            onSaved: (value) => _name = value,
          ),
          vspace16,
          RaisedButton(
            child: Text(Strings.next),
            color: Style.accentColor1,
            onPressed: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .popAndPushNamed(Routes.uoAgeScreen);
              }
            },
          ),
          FlatButton(
            child: Text(Strings.back),
            textColor: Style.textLightColor,
            onPressed: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class UOAgeScreen extends StatefulWidget {
  @override
  _UOAgeScreenState createState() => _UOAgeScreenState();
}

class _UOAgeScreenState extends State<UOAgeScreen> {
  final key = GlobalKey<FormState>();
  String _yearOfBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Hallo!",
        subtitle: "Was ist dein Geburtsjahr?",
        header: _logoHeader,
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
          TextFormField(
            initialValue:
                _yearOfBirth != null ? _yearOfBirth.toString() : "1900",
            decoration: InputDecoration(labelText: "Geburtsjahr"),
            validator: (value) => null,
            onSaved: (value) => _yearOfBirth = value,
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          vspace16,
          RaisedButton(
            child: Text(Strings.next),
            color: Style.accentColor1,
            onPressed: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() {
                  form.save();
                });
                ExtendedNavigator.of(context)
                    .popAndPushNamed(Routes.uoDiagnosisPage1);
              }
            },
          ),
        ],
      ),
    );
  }
}
