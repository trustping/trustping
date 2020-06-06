import 'package:flutter/material.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

import '../spaces.dart';

Widget buildOnboardingContent({
  BuildContext context,
  String title,
  String subtitle,
  Widget header,
  Widget form,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          header,
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
    ),
  );
}

/// Draw n circles of wich i are done (filled)
class TPProgressIndicator extends StatelessWidget {
  final int i;
  final int n;
  final String section;
  final Color color;
  const TPProgressIndicator({Key key, this.i, this.n, this.section, this.color})
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
          Text(section, style: Style.subtitleTS.copyWith(color: color)),
        Row(
          children: List.generate(n, (index) => index < i ? doneDot : todoDot),
        ),
        vspace32,
      ],
    );
  }
}

Widget buildButtonNav({context, onNext, onBack}) {
  return ButtonBar(
    alignment: MainAxisAlignment.spaceEvenly,
    buttonMinWidth: 150,
    children: <Widget>[
      FlatButton(
        child: Text(Strings.back),
        textColor: Style.textDarkColor,
        onPressed: onBack,
      ),
      RaisedButton(
        child: Text(Strings.next),
        color: Style.yellow,
        onPressed: onNext,
      ),
    ],
  );
}
