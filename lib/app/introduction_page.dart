import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trust_ping_app/app/user_profile_page.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntroductionScreen(
      pages: [
        _buildPageViewModel(
          title: 'TrustPing',
          subtitle:
              "... ist eine App mit der Menschen mit Krebs gezielt Gesprächspartner finden, ohne sensible Informationen aus der Hand zu geben.",
          assetPath: "assets/images/boxes.png",
          textTheme: textTheme,
        ),
        _buildPageViewModel(
          title: "Let's start",
          assetPath: "assets/images/boxes.png",
          subtitle:
              "Um fuer dich passende Gespraechspartner zu finden brauchen wir ein paar Informationen ueber dich",
          textTheme: textTheme,
        ),
        _buildPageViewModel(
          title: "Transparenz und Integrietaet",
          assetPath: "assets/images/boxes.png",
          subtitle: "Das Herz von TrustPing ist Transparenz und Integrietaet.",
          body: "moretn ersint ianrsti enarso",
          textTheme: textTheme,
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
    textTheme,
  }) {
    return PageViewModel(
      titleWidget: _IntroPageWidget(
        title: title,
        subtitle: subtitle,
        body: body,
        assetPath: assetPath,
        textTheme: textTheme,
      ),
      body: "",
    );
  }
}

// Helper to easily create the actual content of a PageViewModel
class _IntroPageWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String body;
  final String assetPath;
  const _IntroPageWidget({
    Key key,
    this.title,
    this.subtitle,
    this.body,
    this.assetPath,
    @required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        vSpace,
        vSpace,
        vSpace,
        Image(
          image: AssetImage(assetPath),
          width: 100.0,
        ),
        spacer,
        Text(title, style: textTheme.headline1),
        spacer,
        Text(
          subtitle,
          style: textTheme.headline6,
        ),
        if (body != null) spacer,
        if (body != null) Text(body)
      ],
    );
  }
}
