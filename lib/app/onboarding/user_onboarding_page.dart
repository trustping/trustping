import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';

// =============================================================================
class UserNameForm extends StatefulWidget {
  final Function onNext;
  const UserNameForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _UserNameFormState createState() => _UserNameFormState();
}

class _UserNameFormState extends State<UserNameForm> {
  final key = GlobalKey<FormState>();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
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
                widget.onNext();
              }
            },
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }
}

class UserAgeForm extends StatefulWidget {
  const UserAgeForm({Key key, @required this.onNext}) : super(key: key);
  final Function onNext;

  @override
  _UserAgeFormState createState() => _UserAgeFormState();
}

class _UserAgeFormState extends State<UserAgeForm> {
  final key = GlobalKey<FormState>();
  String _yearOfBirth = "";

  @override
  Widget build(BuildContext context) {
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
                widget.onNext();
              }
            },
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }
}
