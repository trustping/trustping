import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/tpstyle.dart';

class IntroductionPage extends StatelessWidget {
  final Function onDone;
  const IntroductionPage({Key key, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        _buildPageViewModel(
          title: 'Herzlich Willkommen bei Trustping!',
          body:
              "Trustping ist eine App mit der Menschen mit oder nach Krebs gezielt Gesprächspartner finden, ohne sensible Informationen aus der Hand zu geben.",
          image: tpIntro1(),
          // image: trustpingImage100,
        ),
        _buildPageViewModel(
          title: "Das ♥ von Trustping sind Transparenz und Integrität.",
          body:
              "Gesundheitsdaten verdienen den allerhöchsten Schutz. Deshalb entscheidest nur Du über deine Daten. Alle Einstellungen kannst Du jederzeit ändern oder Daten endgültig löschen",
          image: tpIntro2(),
        ),
        _buildPageViewModel(
          title: "Der Ping aus Trustping",
          body: """Um  neue Gesprächspartner zu finden, erstellst Du einen Ping.

Ein Ping ist eine Kontaktanfrage.

Er enthält von Dir gewählte Interessen und Profilinformationen  und möglicherweise auch eine persönliche Nachricht oder Frage.""",
          image: tpIntro3(),
          // subBody:
          //     "Usam quo tecus id modi omnihil laccusdant cerferchilia simusam quo tecus idem.",
        ),
        _buildPageViewModel(
          title: "Das Matching: So finden wir Deine Gesprächspartner",
          body:
              """Mithilfe eines Algorithmus und den vorhandenen Informationen wählen wir passende Menschen aus und senden ihnen Deinen Ping anonymisiert zu. Sie können darauf antworten und Du entscheidest, ob ein Chat beginnt.""",
          image: tpIntro4(),
        ),
        _buildPageViewModel(
          title: "Ping erhalten",
          body:
              """Wenn Du selbst einen Ping von jemandem erhältst, kannst Du darauf antworten. Reagiert Dein Gesprächspartner auf diese Antwort, beginnt ein Chat.

Ein Ping, der für Dich nicht relevant ist, kannst Du ignorieren oder löschen.""",
          image: tpIntro5(),
          // subBody:
        ),
        _buildPageViewModel(
          title: "Los geht's",
          body:
              "Um für Dich passende Gesprächspartner zu finden, brauchen wir ein paar Informationen.",
          image: tpIntro6(),
          // subBody:
          //     "Usam quo tecus id modi omnihil laccusdant cerferchilia simusam quo tecus idem.",
        ),
      ],
      next: const Icon(Icons.forward),
      done: const Text("FERTIG", style: TextStyle(fontWeight: FontWeight.w600)),
      skip: const Text("SKIP", style: TextStyle(fontWeight: FontWeight.w300)),
      onDone: onDone,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        // activeColor: theme.accentColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onSkip: onDone,
      showSkipButton: true,
    );
  }

  PageViewModel _buildPageViewModel({
    String title,
    String body,
    String subBody,
    Widget image,
  }) {
    const spacer = SizedBox(height: 16.0);
    return PageViewModel(
      titleWidget: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 92.0, 42.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            image,
            spacer,
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40, 0),
              child: TPStyle.title(title),
            ),
            spacer,
            TPStyle.body(body),
            if (subBody != null) spacer,
            if (subBody != null) TPStyle.tiny(subBody)
          ],
        ),
      ),
      body: "",
    );
  }
}
