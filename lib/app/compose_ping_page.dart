import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';
import 'package:trust_ping_app/app/home/view_models/ping_view_model.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';

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
            buildPingCard(context),
          ],
        ),
      ),
    );
  }

  Widget buildPingCard(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: true);

    return StreamBuilder<UserProfile>(
      stream: db.userProfileStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userProfile = snapshot.data;
          return ComposePingCard(
            pingViewModel: PingViewModel(
              userProfile: userProfile,
              db: db,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
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
                '\n\nBitte erstelle eine Ping Nachricht um die Personen zu kontaktieren.',
          ),
        ],
      ),
    );
  }
}

class ComposePingCard extends StatefulWidget {
  final PingViewModel pingViewModel;
  const ComposePingCard({
    Key key,
    this.pingViewModel,
  }) : super(key: key);

  @override
  _ComposePingCardState createState() => _ComposePingCardState();
}

class _ComposePingCardState extends State<ComposePingCard> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ListTile(leading: Icon(Icons.message), title: Text('Hallo!')),
          _buildCustomMessageComposer(),
          const ListTile(title: Text('Teile Details aus deinem Profil:')),
          _buildSwitchSentences(),
          buildButtonBar(context),
        ],
      ),
      margin: EdgeInsets.all(16.0),
      elevation: 8,
    );
  }

  ButtonBar buildButtonBar(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          child: const Text('weiter'),
          color: Style.yellow,
          textColor: Style.textColor,
          onPressed: () {
            showConfirmDialog(
              context: context,
              msg: widget.pingViewModel.compose(_textController.text),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSwitchSentences() {
    return Column(
      children: <Widget>[
        SwitchSentenceWidget(
          sentence: widget.pingViewModel.nameSentence,
          active: widget.pingViewModel.useName,
          onChanged: (bool value) {
            setState(() => widget.pingViewModel.useName = value);
          },
        ),
        SwitchSentenceWidget(
          sentence: widget.pingViewModel.yearOfBirthSentence,
          active: widget.pingViewModel.useYearOfBirth,
          onChanged: (bool value) {
            setState(() => widget.pingViewModel.useYearOfBirth = value);
          },
        ),
        SwitchSentenceWidget(
          sentence: widget.pingViewModel.cancerTypeSentence,
          active: widget.pingViewModel.useCancer,
          onChanged: (bool value) {
            setState(() => widget.pingViewModel.useCancer = value);
          },
        ),
        SwitchSentenceWidget(
          sentence: widget.pingViewModel.therapySentence,
          active: widget.pingViewModel.useTherapy,
          onChanged: (bool value) {
            setState(() => widget.pingViewModel.useTherapy = value);
          },
        ),
        SwitchSentenceWidget(
          sentence: widget.pingViewModel.circumstancesSentence,
          active: widget.pingViewModel.useCircumstances,
          onChanged: (bool value) {
            setState(() => widget.pingViewModel.useCircumstances = value);
          },
        ),
      ],
    );
  }

  showConfirmDialog({BuildContext context, String msg}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ping senden?"),
          content: Text(
            msg,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("abbrechen"),
              textColor: Style.textLightColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("senden"),
              color: Style.yellow,
              textColor: Style.textColor,
              onPressed: () {
                widget.pingViewModel.sendPing(
                  widget.pingViewModel.compose(_textController.text),
                );
                ExtendedNavigator.of(context)
                    .popUntil((route) => route.isFirst);
                Flushbar(
                  message: 'Pings unterwegs...',
                  duration: Duration(seconds: 3),
                ).show(context);
              },
            )
          ],
          elevation: 24.0,
        );
      },
    );
  }

  Padding _buildCustomMessageComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textController,
        maxLines: 4,
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {},
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText:
              "Schreibe eine persoenliche Nachricht an deinen Gespraechstpartner.",
        ),
      ),
    );
  }
}

/// Widget to (de)activate the sentence to send.
class SwitchSentenceWidget extends StatelessWidget {
  final bool active;
  final String sentence;
  final Function onChanged;

  const SwitchSentenceWidget(
      {Key key, this.sentence, this.active, this.onChanged})
      : super(key: key);

  static const _inactiveStyle =
      TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black45);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        sentence,
        style: active ? null : _inactiveStyle,
      ),
      value: active,
      dense: true,
      onChanged: (bool value) => onChanged(value),
    );
  }
}
