import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/theme.dart';

class IntroductionPage extends StatelessWidget {
  final Function onDone;
  const IntroductionPage({Key key, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        _buildPageViewModel(
          title: 'Herzlich Willkommen bei Trustping!',
          body: "",
        ),
        _buildPageViewModel(
          title: "Trustping",
          body:
              "Trustping findet Menschen in ähnlichen Situationen und verbindet sie findet Menschen in ähnlichen Situationen und verbindet ndet Menschen in ähnlichen Situationen und verbindet",
          subBody:
              "Trustping findet Menschen in ähnlichen Situationen und verbindet sie findet Menschen in ähnlichen Situationen und verbindet ndet Menschen in ähnlichen Situationen und verbindet",
        ),
        _buildPageViewModel(
          title: "Let’s start",
          body:
              "Um für Dich passende Gesprächspartner zu finden, brauchen wir ein paar Informationen.",
          subBody:
              "Usam quo tecus id modi omnihil laccusdant cerferchilia simusam quo tecus idem.",
        ),
      ],
      next: const Icon(Icons.forward),
      done: const Text("FERTIG", style: TextStyle(fontWeight: FontWeight.w600)),
      skip: const Text("SKIP", style: TextStyle(fontWeight: FontWeight.w300)),
      onDone: onDone,
      onSkip: onDone,
      showSkipButton: true,
    );
  }

  PageViewModel _buildPageViewModel({
    String title,
    String body,
    String subBody,
  }) {
    const spacer = SizedBox(height: 16.0);
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 92.0, 24.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            trustpingImage,
            spacer,
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40, 0),
              child: Style.title(title),
            ),
            spacer,
            Style.body(body),
            if (subBody != null) spacer,
            if (subBody != null) Style.tiny(subBody)
          ],
        ),
      ),
      body: "",
    );
  }
}
