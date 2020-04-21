import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Trust Ping",
          body:
              "... ist eine App mit der Menschen mit Krebs gezielt Gesprächspartner finden, ohne sensible Informationen aus der Hand zu geben.",
          image: Center(
            child: Image(image: AssetImage("assets/images/dummy_logo.png")),
          ),
        ),
        PageViewModel(
          title: "Finde Gespraechspartner",
          body: "Trust Ping findet Menchen in aenlichen Situationen.",
          footer: Text("mehr text..."),
          image: Center(
            child: Image(image: AssetImage("assets/images/dummy_network.png")),
          ),
        ),
      ],
      next: const Icon(Icons.forward),
      done: const Text("DONE", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => _gotoChatsPage(context),
      skip: const Text("SKIP", style: TextStyle(fontWeight: FontWeight.w300)),
      onSkip: () => _gotoChatsPage(context),
      showSkipButton: true,
    );
  }

  void _gotoChatsPage(context) => ExtendedNavigator.of(context).pop(context);
}
