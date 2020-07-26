import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

// =============================================================================
class UserNameForm extends StatefulWidget {
  final Function onNext;
  final UserProfileV2 profile;
  const UserNameForm({Key key, @required this.profile, @required this.onNext})
      : super(key: key);

  @override
  _UserNameFormState createState() => _UserNameFormState();
}

class _UserNameFormState extends State<UserNameForm> {
  final key = GlobalKey<FormState>();
  String _name = "";

  @override
  void initState() {
    super.initState();
    if (widget.profile.name != null) {
      _name = widget.profile.name;
    }
  }

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
            onNext: _submit,
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final form = this.key.currentState;
    if (form.validate()) {
      setState(() => form.save());

      final db = Provider.of<FirestoreDatabase>(context, listen: false);
      db.setUserProfileV2(_userProfileFromState());

      widget.onNext();
    }
  }

  UserProfileV2 _userProfileFromState() {
    final newProfile = widget.profile.copyWith(name: _name);
    return newProfile;
  }
}

// =============================================================================
class UserAgeForm extends StatefulWidget {
  final UserProfileV2 profile;
  final Function onNext;
  const UserAgeForm({Key key, @required this.profile, @required this.onNext})
      : assert(profile != null),
        super(key: key);

  @override
  _UserAgeFormState createState() => _UserAgeFormState();
}

class _UserAgeFormState extends State<UserAgeForm> {
  final key = GlobalKey<FormState>();
  int _yearOfBirth;

  @override
  void initState() {
    super.initState();
    _yearOfBirth = widget.profile.yearOfBirth;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            initialValue: (_yearOfBirth != null) ? _yearOfBirth.toString() : "",
            decoration: InputDecoration(hintText: "Geburtsjahr"),
            validator: (value) => null,
            onSaved: (value) => _yearOfBirth = int.tryParse(value),
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          buildButtonNav(
            context: context,
            onNext: _submit,
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final form = this.key.currentState;
    if (form.validate()) {
      setState(() => form.save());

      final db = Provider.of<FirestoreDatabase>(context, listen: false);
      db.setUserProfileV2(_userProfileFromState());

      widget.onNext();
    }
  }

  UserProfileV2 _userProfileFromState() {
    return widget.profile.copyWith(yearOfBirth: _yearOfBirth);
  }
}
