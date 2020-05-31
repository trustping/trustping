import 'package:flutter/material.dart';
import 'package:trust_ping_app/theme.dart';

class UserOnboardingPage extends StatefulWidget {
  @override
  _UserOnboardingPageState createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  static const vspace16 = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trustping"),
      ),
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          Image.asset("assets/images/boxes.png", height: 100),
          vspace16,
          ProgressIndicator(
              i: 1, n: 2, section: "Foo", color: Style.accentColor3),
          vspace16,
          vspace16,
          Style.title("Hallo!"),
          vspace16,
          Style.subtitle("Wie möchtest Du angesprochen werden?"),
          vspace16,
          TextField(
            decoration:
                InputDecoration(hintText: "Dein Name", labelText: "Dein Name"),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("ÜBERSPRINGEN"),
                    onPressed: () {},
                    textColor: Style.textLightColor,
                    disabledTextColor: Style.textLightColor,
                  ),
                  RaisedButton(
                    child: Text("WEITER"),
                    color: Style.accentColor1,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          vspace16,
          vspace16,
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
        if (section != null)
          Text(
            section,
            style: TextStyle(color: color),
          ),
        Row(
          children: List.generate(n, (index) => index < i ? doneDot : todoDot),
        ),
      ],
    );
  }
}