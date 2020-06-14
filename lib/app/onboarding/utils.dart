import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/common_widgets/buttons.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

Widget buildOnboardingContent({
  BuildContext context,
  String title,
  String body,
  Widget header,
  Widget form,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          header,
          vspace40,
          Style.title(title),
          vspace16,
          Style.body(body),
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
  final List<Color> colors;
  const TPProgressIndicator(
      {Key key, this.i, this.n, this.section, this.colors})
      : assert(i != null),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors[0],
      ),
    );
    final todoDot = Container(
      margin: _margin,
      width: _dotSize,
      height: _dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 0.7, color: colors[0]),
        color: colors[3],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (section != null)
          Text(
            section,
            style: Style.tinyTS.copyWith(color: colors[0]),
          ),
        Row(
          children: List.generate(n, (index) => index < i ? doneDot : todoDot),
        ),
      ],
    );
  }
}

Widget buildButtonNav({
  BuildContext context,
  Function onNext,
  String onNextButtonText,
  Function onSkip,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      vspace32,
      vspace32,
      TPButton.primary(
        text: onNextButtonText ?? Strings.next,
        onPressed: onNext,
      ),
      if (onSkip != null) vspace16,
      if (onSkip != null)
        TPButton.secondary(
          text: Strings.skip,
          onPressed: onSkip,
        ),
    ],
  );
}
