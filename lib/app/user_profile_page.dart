import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

const vSpace = SizedBox(height: 16.0);

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Profil anpassen")),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder<UserProfile>(
              stream: db.userProfileStream(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return UserInputForm(userProfile: snapshot.data);
              },
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
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
  List<String> _interests;

  @override
  void initState() {
    super.initState();
    _name = (widget.userProfile == null) ? "" : widget.userProfile.name;
    _interests =
        (widget.userProfile == null) ? [] : widget.userProfile.interests;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _SectionHead(
              title: "Hallo! Wie ist dein Name?",
              body:
                  "Der Name ist nich oeffentlich sichtbar und wird nur Leuten mitgeteilt, die du kontaktiert.",
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
            vSpace,
            vSpace,
            _SectionHead(
              title: "Deine Interessen",
              body:
                  "Ueber welche Themen willst du mit anderen Leuten sprechen?",
            ),
            _buildInterestFilter(context),
            vSpace,
            FlatButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _submit(context);
                  // If the form is valid, display a snackbar.
                  Navigator.of(context).pop();
                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(content: Text('Fake Processing Data')),
                  // );

                  Flushbar(
                    message: 'Profil wird gespeichert',
                    duration: Duration(seconds: 3),
                  ).show(context);
                }
              },
              child: Text('Weiter'),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }

  Widget _buildInterestFilter(context) {
    return Wrap(
      children: allInterests.map<Widget>(
        (item) {
          return Container(
            child: FilterChip(
              label: Text(item),
              avatar: CircleAvatar(child: Text(item[0][0].toUpperCase())),
              selected: _interests.contains(item),
              onSelected: (bool selected) {
                print(selected);
                setState(() {
                  if (selected) {
                    _interests.add(item);
                  } else {
                    _interests.removeWhere((String name) => name == item);
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
    final newUserProfile =
        UserProfile(id: db.userID, name: _name, interests: _interests);
    print("New user $newUserProfile");
    print("$_name");
    print("$_interests");
    db.setUserProfile(newUserProfile);
  }
}

class _SectionHead extends StatelessWidget {
  final String title;
  final String body;
  const _SectionHead({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleTheme = Theme.of(context).textTheme.display1.copyWith();
    final _suptitleTheme =
        Theme.of(context).textTheme.body1; //.merge(TextStyle(fontSize: 18));

    return Column(
      children: [
        Text(
          title,
          style: _titleTheme,
          textAlign: TextAlign.start,
        ),
        vSpace,
        Text(body, style: _suptitleTheme),
      ],
    );
  }
}
