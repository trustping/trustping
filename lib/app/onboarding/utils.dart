import 'package:flutter/material.dart';
import 'package:trust_ping_app/theme.dart';

import '../spaces.dart';

Widget buildOnboardingContent({
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
