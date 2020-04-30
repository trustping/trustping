import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

class ComposePingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ping senden"),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            buildIntroText(),
            buildPing(context),
          ],
        ),
      ),
    );
  }

  Widget buildPing(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder<UserProfile>(
        stream: db.userProfileStream(),
        builder: (context, snapshot) {
          final userProfile = snapshot.data;

          return ComposePingCard(userProfile: userProfile);
        });
  }

  Widget buildIntroText() {
    final _defaultStyle = TextStyle(fontSize: 18.0, color: Colors.black54);
    final _empStyle = TextStyle(fontWeight: FontWeight.w900);

    return RichText(
      text: TextSpan(
        style: _defaultStyle,
        children: [
          TextSpan(text: 'Wir haben'),
          TextSpan(text: ' 5', style: _empStyle),
          TextSpan(text: ' potentielle Gespraechspartner fuer dich gefunden.'),
          TextSpan(
              text:
                  '\n\nBitte erstelle eine Ping Nachricht um die Personen zu kontaktieren.'),
        ],
      ),
    );
  }
}

class ComposePingCard extends StatefulWidget {
  final UserProfile userProfile;
  const ComposePingCard({
    Key key,
    this.userProfile,
  }) : super(key: key);

  @override
  _ComposePingCardState createState() => _ComposePingCardState();
}

class _ComposePingCardState extends State<ComposePingCard> {
  bool _useName = true;
  bool _useYearOfBirth = true;
  bool _useInterests = true;
  bool _useCircumstances = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const _inactiveStyle = TextStyle(
        decoration: TextDecoration.lineThrough, color: Colors.black45);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Card(
          child: Column(
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.message),
                title: Text('Hallo!'),
              ),
              SwitchListTile(
                title: Text(
                  'Mein Name ist *${widget.userProfile.name}*.',
                  style: _useName ? null : _inactiveStyle,
                ),
                value: _useName,
                onChanged: (bool value) {
                  setState(() {
                    _useName = value;
                  });
                },
                dense: true,
              ),
              SwitchListTile(
                title: Text(
                  'Ich bin Jahrgang *${widget.userProfile.yearOfBirth}*.',
                  style: _useYearOfBirth ? null : _inactiveStyle,
                ),
                value: _useYearOfBirth,
                onChanged: (bool value) {
                  setState(() {
                    _useYearOfBirth = value;
                  });
                },
                dense: true,
              ),
              SwitchListTile(
                title: Text(
                  'Ich interessiere mich fuer: *${widget.userProfile.interests.join(", ")}*.',
                  style: _useInterests ? null : _inactiveStyle,
                ),
                value: _useInterests,
                onChanged: (bool value) {
                  setState(() {
                    _useInterests = value;
                  });
                },
                // secondary: const Icon(Icons.person),
                dense: true,
              ),
              SwitchListTile(
                title: Text(
                  'Meine Lebensumstaende: *${widget.userProfile.circumstances.join(", ")}*.',
                  style: _useCircumstances ? null : _inactiveStyle,
                ),
                value: _useCircumstances,
                onChanged: (bool value) {
                  setState(() {
                    _useCircumstances = value;
                  });
                },
                // secondary: const Icon(Icons.person),
                dense: true,
              ),
              Text("TODO Alle Daten aus dem Profil anzeigen."),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        "Schreibe eine persoenliche Nachricht an deinen Gespraechstpartner."),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('WEITER'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.all(16.0),
          elevation: 4,
        ),
      ),
    );
  }
}
