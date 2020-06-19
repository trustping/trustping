import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/chats_tab.dart';
import 'package:trust_ping_app/common_widgets/images.dart';

class PingsTab extends StatelessWidget {
  const PingsTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TPStyledListTile(
          // leading: trustpingImage,
          // leading: Icon(Icons.inbox),
          leading: Image.asset("assets/images/logo_2of3.png"),
          titleString: "Deine Anfrage",
          trailingString: "Mon.\n11. Juni",
          subtitleString:
              "Hallo, ich moechte mich zu Nebenwirkung XYZ austauschen...",
          onTap: null,
        ),
        TPStyledListTile(
          leading: Image.asset("assets/images/logo_1of3.png"),
          // leading: Icon(Icons.inbox),
          titleString: "Anfrage von <Anonym>",
          trailingString: "Mon.\n11. Juni",
          subtitleString:
              "Hallo, ich moechte sneoat arsanutfioan snet ao naonfe...",
          onTap: null,
        ),
        TPStyledListTile(
          leading: Image.asset("assets/images/logo_3of3.png"),
          // leading: Icon(Icons.inbox),
          titleString: "Anfrage von Stefan",
          trailingString: "Mon.\n19. Juni",
          subtitleString: "Hallo, Yoga und Krebs...",
          onTap: null,
        ),
      ],
    );
  }
}
