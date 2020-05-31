import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

class UserOnboardingPage extends StatefulWidget {
  @override
  _UserOnboardingPageState createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  final key = GlobalKey<FormState>();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: _buildOnboardingContent(
        context: context,
        title: "Hallo!",
        subtitle: "Wie möchtest Du angesprochen werden?",
        currentStep: 1,
        totalSteps: 2,
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
                setState(() {
                  form.save();
                });
                print(_name);

                ExtendedNavigator.of(context)
                    .pushNamed(Routes.userOnboardingNameScreen);
                // TODO navigate to next page
                // TODO store in firebase
              }
            },
          ),
        ],
      ),
    );
  }
}

// HELPERS
Widget _buildOnboardingContent({
  BuildContext context,
  String title,
  String subtitle,
  int currentStep,
  int totalSteps,
  Widget form,
}) {
  return Padding(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: <Widget>[
        SizedBox(
          child: Image.asset("assets/images/boxes.png", height: 100),
          height: 100,
        ),
        vspace16,
        ProgressIndicator(
            i: currentStep, n: totalSteps, color: Style.accentColor3),
        vspace32,
        Style.title(title),
        vspace16,
        Style.subtitle(subtitle),
        vspace16,
        form,
        vspace32,
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
    ),
  );
}

class UserOnboardingNameScreen extends StatefulWidget {
  @override
  _UserOnboardingNameScreenState createState() =>
      _UserOnboardingNameScreenState();
}

class _UserOnboardingNameScreenState extends State<UserOnboardingNameScreen> {
  final key = GlobalKey<FormState>();
  String _yearOfBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: _buildOnboardingContent(
        context: context,
        title: "Hallo!",
        subtitle: "Was ist dein Geburtsjahr?",
        currentStep: 2,
        totalSteps: 2,
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
                // print(_name);
                // TODO navigate to next page
                // TODO store in firebase
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Draw n circles of wich i are done (filled)
class ProgressIndicator extends StatelessWidget {
  final int i;
  final int n;
  final String section;
  final Color color;
  const ProgressIndicator({Key key, this.i, this.n, this.section, this.color})
      : assert(color != null),
        assert(i != null),
        assert(n != null),
        super(key: key);

  static final double _dotSize = 10.0;
  static final EdgeInsets _margin = EdgeInsets.fromLTRB(0, 8, 4, 4);

  @override
  Widget build(BuildContext context) {
    final Container doneDot = Container(
      margin: _margin,
      width: _dotSize,
      height: _dotSize,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
    final todoDot = Container(
      margin: _margin,
      width: _dotSize,
      height: _dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: color),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (section != null) Text(section, style: TextStyle(color: color)),
        Row(
          children: List.generate(n, (index) => index < i ? doneDot : todoDot),
        ),
      ],
    );
  }
}
