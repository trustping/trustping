import 'package:flutter/material.dart';

class ComposePingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ping senden"),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          buildIntroText(),
          buildPing(context),
        ],
      ),
    );
  }

  Widget buildPing(BuildContext context) {
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
                title: const Text('Mein name ist _Stefan_.'),
                value: true,
                onChanged: (bool value) {},
                // secondary: const Icon(Icons.person),
                dense: true,
              ),
              SwitchListTile(
                title: const Text(
                  'Ich interessiere mich fuer _Yoga_, und _Ernaehrung_.',
                ),
                value: true,
                onChanged: (bool value) {},
                // secondary: const Icon(Icons.person),
                dense: true,
              ),
              SwitchListTile(
                title: const Text(
                  'TODO alle anderen Attribute aus dem Profil hinzufuegen.',
                ),
                value: true,
                onChanged: (bool value) {},
                // secondary: const Icon(Icons.person),
                dense: true,
              ),
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
                    child: const Text('PING SENDEN'),
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

  Widget buildIntroText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18.0, color: Colors.black54),
        children: [
          TextSpan(text: 'Wir haben'),
          TextSpan(text: ' 5', style: TextStyle(fontWeight: FontWeight.w900)),
          TextSpan(text: ' potentielle Gespraechspartner fuer dich gefunden.'),
          TextSpan(
              text:
                  '\n\nBitte erstelle eine Ping Nachricht um die Personen zu kontaktieren.'),
        ],
      ),
    );
  }
}
