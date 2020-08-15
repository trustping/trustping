import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/chats_tab.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';
import 'package:trust_ping_app/utils.dart';

class Ping {
  final String subject;
  final String request;
  final String requestTS;
  final int unread;
  final List<PingResponse> responses;
  final PingType pingType;
  final String author;

  Ping({
    @required this.subject,
    @required this.request,
    @required this.pingType,
    @required this.unread,
    @required this.requestTS,
    @required this.responses,
    @required this.author,
  });
}

enum PingState { ping, pong, done }
enum PingType { outgoing, incoming }

class PingResponse {
  final String response;
  final String authorName;
  final String responseTS;
  final String chatID;
  final PingState pingState;

  PingResponse({
    @required this.response,
    @required this.authorName,
    @required this.responseTS,
    @required this.chatID,
    @required this.pingState,
  });
}

List<Ping> _pings = [
  Ping(
    subject: "Suche Chatfreunde mit gleicher Problematik",
    request: "Hallo, ich moechte mich einfach ueber XYZ auttauschen.",
    unread: 0,
    requestTS: "11. Aug",
    pingType: PingType.outgoing,
    author: "Stefan",
    responses: [],
  ),
  Ping(
    subject: "Reha in Wittstock",
    request: "Weiß jemand bescheid in Sachen ambulante Reha in Wittstock?",
    requestTS: "11. Aug",
    unread: 1,
    pingType: PingType.outgoing,
    author: "Stefan",
    responses: [
      PingResponse(
        response: "Ich war vor einem Jahr da und ...",
        authorName: "Peter",
        responseTS: "12. Aug",
        chatID: "CHAT ID FAKE",
        pingState: PingState.done,
      ),
      PingResponse(
        response: "Ja, wir koennen uns gerne dazu austauschen, ...",
        authorName: "Anynom",
        responseTS: "12. Aug",
        chatID: "CHAT ID FAKE",
        pingState: PingState.pong,
      ),
    ],
  ),
  Ping(
    subject: "Nebenwirkungen vom Medikament...",
    request:
        "Hallo, ich moechte mich oaienufn uo rstne aufn ianste ioarnst arst rt ar.",
    unread: 0,
    requestTS: "11. Aug",
    pingType: PingType.incoming,
    author: "na",
    responses: [],
  ),
  Ping(
    subject: "Haarausfall",
    request: "Hallo, ich moechte mich lorem ipsum...",
    requestTS: "11. Aug",
    unread: 1,
    pingType: PingType.incoming,
    author: "na",
    responses: [
      PingResponse(
        chatID: null,
        authorName: "Anynom",
        response: "ja, bitte.",
        responseTS: "12. Aug",
        pingState: PingState.pong,
      )
    ],
  )
];

class PingsTab extends StatelessWidget {
  const PingsTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxes = [
      SizedBox(
          height: 48,
          width: 48,
          child: Container(color: Style.red, child: Icon(Icons.arrow_forward))),
      SizedBox(
          height: 48,
          width: 48,
          child:
              Container(color: Style.blue, child: Icon(Icons.arrow_forward))),
      SizedBox(
          height: 48,
          width: 48,
          child:
              Container(color: Style.yellow, child: Icon(Icons.arrow_forward))),
    ];
    return ListView(
      children: _pings.map(
        (ping) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TPStyledListTile(
              // leading: Image.asset("assets/images/logo_2of3.png"),
              leading: ping.author == "Stefan"
                  ? randomChoice(boxes)
                  : trustpingImage100,
              titleString: pingTitle(ping),
              trailingString: ping.requestTS,
              subtitleString: ping.request.substring(0, 40) + "...",
              onTap: () => ExtendedNavigator.of(context).pushNamed(
                Routes.pingPage,
                arguments: PingPageArguments(ping: ping),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

String pingTitle(Ping ping) {
  return ping.subject;
}
