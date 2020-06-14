import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

final Widget _logoHeader = SizedBox(
  child: Image.asset("assets/images/boxes.png", height: 100),
  height: 100,
);

class UONamePage extends StatefulWidget {
  @override
  _UONamePageState createState() => _UONamePageState();
}

class _UONamePageState extends State<UONamePage> {
  final key = GlobalKey<FormState>();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Hallo!",
        body: "Wie möchtest Du angesprochen werden?",
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
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context).pushNamed(Routes.uoAgePage);
              }
            },
            onSkip: () =>
                ExtendedNavigator.of(context).pushNamed(Routes.uoAgePage),
          ),
        ],
      ),
    );
  }
}

class UOAgePage extends StatefulWidget {
  @override
  _UOAgePageState createState() => _UOAgePageState();
}

class _UOAgePageState extends State<UOAgePage> {
  final key = GlobalKey<FormState>();
  String _yearOfBirth = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Hallo!",
        body: "Was ist dein Geburtsjahr?",
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
            initialValue: _yearOfBirth,
            decoration: InputDecoration(hintText: "Geburtsjahr"),
            validator: (value) => null,
            onSaved: (value) => _yearOfBirth = value,
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .pushNamed(Routes.uoDiagnosisPage1);
              }
            },
            onSkip: () => ExtendedNavigator.of(context)
                .pushNamed(Routes.uoDiagnosisPage1),
          ),
        ],
      ),
    );
  }
}
