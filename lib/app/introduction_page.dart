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
          title: 'Trustping ist tnfeoianst arsietn arsot',
          subtitle:
              "... ist eine App mit der Menschen mit Krebs gezielt Gesprächspartner finden, ohne sensible Informationen aus der Hand zu geben.",
          body:
              "tnsireantio naresitn aiorsnt ironsat eiornst arisotte irnset irnste iarnst aresnt rsiont rseiotn",
          assetPath: "assets/images/boxes.png",
        ),
        _buildPageViewModel(
          title: "Let's start",
          assetPath: "assets/images/boxes.png",
          subtitle:
              "Um fuer dich passende Gespraechspartner zu finden brauchen wir ein paar Informationen ueber dich",
        ),
        _buildPageViewModel(
          title: "Transparenz und Integrietaet",
          assetPath: "assets/images/boxes.png",
          subtitle: "Das Herz von Trustping ist Transparenz und Integrietaet.",
          body: "moretn ersint ianrsti enarso",
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
        padding: const EdgeInsets.fromLTRB(16.0, 92.0, 32.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage(assetPath),
              width: 100.0,
            ),
            spacer,
            Style.title(title),
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
