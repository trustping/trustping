import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trust_ping_app/theme.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        _buildPageViewModel(
          title: 'Herzlich Willkommen bei Trustping!',
          subtitle: "",
          assetPath: "assets/images/boxes.png",
        ),
        _buildPageViewModel(
          title: "Trustping",
          subtitle:
              "Trustping findet Menschen in ähnlichen Situationen und verbindet sie findet Menschen in ähnlichen Situationen und verbindet ndet Menschen in ähnlichen Situationen und verbindet",
          body:
              "Trustping findet Menschen in ähnlichen Situationen und verbindet sie findet Menschen in ähnlichen Situationen und verbindet ndet Menschen in ähnlichen Situationen und verbindet",
          assetPath: "assets/images/boxes.png",
        ),
        _buildPageViewModel(
          title: "Let’s start",
          subtitle:
              "Um für Dich passende Gesprächspartner zu finden, brauchen wir ein paar Informationen.",
          body:
              "Usam quo tecus id modi omnihil laccusdant cerferchilia simusam quo tecus idem.",
          assetPath: "assets/images/boxes.png",
        ),
      ],
      next: const Icon(Icons.forward),
      done: const Text("FERTIG", style: TextStyle(fontWeight: FontWeight.w600)),
      skip: const Text("SKIP", style: TextStyle(fontWeight: FontWeight.w300)),
      // skip: const Icon(Icons.skip_next),
      onDone: () => _gotoChatsPage(context),
      onSkip: () => _gotoChatsPage(context),
      showSkipButton: true,
    );
  }

  void _gotoChatsPage(context) => ExtendedNavigator.of(context).pop(context);

  PageViewModel _buildPageViewModel({
    title,
    subtitle,
    body,
    assetPath,
  }) {
    const spacer = SizedBox(height: 16.0);
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 92.0, 24.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage(assetPath),
              width: 100.0,
            ),
            spacer,
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40, 0),
              child: Style.title(title),
            ),
            spacer,
            Style.subtitle(subtitle),
            if (body != null) spacer,
            if (body != null) Text(body)
          ],
        ),
      ),
      body: "",
    );
  }
}
