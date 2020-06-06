import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Profil anpassen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<UserProfile>(
          stream: db.userProfileStream(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: UserInputForm(userProfile: snapshot.data),
            );
          },
        ),
      ),
    );
  }
}

class UserInputForm extends StatefulWidget {
  final UserProfile userProfile;
  const UserInputForm({Key key, this.userProfile}) : super(key: key);

  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _yearOfBirth;
  List<String> _selectedInterests;
  List<String> _selectedCircumstances;

  @override
  void initState() {
    super.initState();
    _name = (widget.userProfile == null) ? "" : widget.userProfile.name;
    _yearOfBirth =
        (widget.userProfile == null) ? null : widget.userProfile.yearOfBirth;
    _selectedInterests =
        (widget.userProfile == null) ? [] : widget.userProfile.interests;
    _selectedCircumstances =
        (widget.userProfile == null) ? [] : widget.userProfile.circumstances;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SectionWidget(
            title: "Hallo! Wie ist dein Name?",
            body:
                "Der Name ist nich oeffentlich sichtbar und kann Leuten mitgeteilt werden die du kontaktiert.",
          ),
          TextFormField(
            initialValue: _name,
            validator: (value) {
              if (value.isEmpty) {
                return 'Bitte gib deinen Namen ein.';
              }
              return null;
            },
            onSaved: (value) => _name = value,
            decoration: InputDecoration(labelText: "Dein Name"),
          ),
          vspace32,
          SectionWidget(
            title: "Lebensumstaende",
            body: "TODO wording\nAlter, Kinder, Berufstaetig/Rente/.../NA",
          ),
          TextFormField(
            initialValue: _yearOfBirth == null ? null : _yearOfBirth.toString(),
            decoration: InputDecoration(labelText: "Dein Geburtsjahr"),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Bitte gib dein Alter ein.';
              }
              return null;
            },
            onSaved: (value) => _yearOfBirth = int.parse(value),
          ),
          _buildCircumstancesFilter(context),
          vspace32,
          SectionWidget(
            title: "Deine Interessen",
            body: "Ueber welche Themen willst du mit anderen Leuten sprechen?",
          ),
          _buildInterestFilter(context),
          vspace32,
          SectionWidget(
            title: "TODO Diagnose",
            body:
                "TODO wording; welche Attribute?\nBrustkrebs: hormon/nicht/Keine Angabe, ...",
          ),
          vspace32,
          SectionWidget(
            title: "TODO Behandlung",
            body:
                "TODO wording; welche Attribute?\nKliniken, Therapien, Behandlungsmethoden",
          ),
          vspace32,
          vspace32,
          FlatButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _submit(context);
                // If the form is valid, display a snackbar.
                Navigator.of(context).pop();
                Flushbar(
                  message: 'Profil wird gespeichert',
                  duration: Duration(seconds: 3),
                ).show(context);
              }
            },
            child: Text('Speichern'),
          ),
          vspace32,
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }

  Widget _buildInterestFilter(context) {
    return _buildFilter(context, ProfileChoices.interests, _selectedInterests);
  }

  Widget _buildCircumstancesFilter(context) {
    return _buildFilter(
      context,
      ProfileChoices.circumstances,
      _selectedCircumstances,
    );
  }

  Widget _buildFilter(
    context,
    List<String> availableChoices,
    List<String> selectedChoices,
  ) {
    return Wrap(
      children: availableChoices.map<Widget>(
        (availableChoice) {
          return Container(
            child: FilterChip(
              label: Text(availableChoice),
              avatar: CircleAvatar(
                child: Text(availableChoice[0][0].toUpperCase()),
              ),
              selected: selectedChoices.contains(availableChoice),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedChoices.add(availableChoice);
                  } else {
                    selectedChoices
                        .removeWhere((String name) => name == availableChoice);
                  }
                });
              },
            ),
            padding: const EdgeInsets.all(4.0),
          );
        },
      ).toList(),
    );
  }

  _submit(context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final newUserProfile = UserProfile(
      id: db.userID,
      name: _name,
      yearOfBirth: _yearOfBirth,
      interests: _selectedInterests,
      circumstances: _selectedCircumstances,
    );
    db.setUserProfile(newUserProfile);
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String body;
  const SectionWidget({Key key, this.title, this.body}) : super(key: key);

  static const space = SizedBox(height: 16.0);

  @override
  Widget build(BuildContext context) {
    final _titleTheme = Theme.of(context).textTheme.display1;
    final _suptitleTheme =
        Theme.of(context).textTheme.body1; //.merge(TextStyle(fontSize: 18));

    return Column(
      children: [
        Text(
          title,
          style: _titleTheme,
          textAlign: TextAlign.left,
        ),
        space,
        Text(body, style: _suptitleTheme),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
