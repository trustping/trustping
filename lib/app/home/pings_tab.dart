import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/chats_tab.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/routing/router.gr.dart';

class Ping {
  final String request;
  final String requestTS;
  final List<PingResponse> responses;
  final PingType pingType;

  Ping({this.request, this.pingType, this.requestTS, this.responses});
}

enum PingState { ping, pong, done }
enum PingType { outgoing, incoming }

class PingResponse {
  final String response;
  final String responseTS;
  final String chatID;
  final PingState pingState;

  PingResponse({this.response, this.responseTS, this.chatID, this.pingState});
}

List<Ping> _pings = [
  Ping(
    request: "Hallo, ich moechte mich zu Nebenwirkung XYZ auttauschen.",
    requestTS: "Mon 11.",
    pingType: PingType.outgoing,
    responses: [
      PingResponse(
        response: "Ich moechte meine Erfahrungen teilen, ...",
        responseTS: "Tue 12.",
        chatID: "CHAT ID FAKE",
        pingState: PingState.pong,
      ),
      PingResponse(
        response: "Ich hatte genau die gleichen Nebenwirkungen, ...",
        responseTS: "Tue 12.",
        chatID: "CHAT ID FAKE",
        pingState: PingState.done,
      ),
    ],
  ),
  Ping(
    request:
        "Hallo, ich moechte nsteinrsati nstmich zu Nebenwirkung XYZ auttauschen.",
    requestTS: "Mon 11.",
    pingType: PingType.outgoing,
    responses: [],
  ),
  Ping(
    request:
        "Hallo, ich moechte mich oaienufn uo rstne aufn ianste ioarnst arst rt ar.",
    requestTS: "Mon 11.",
    pingType: PingType.incoming,
    responses: [],
  ),
  Ping(
    request: "Hallo, ich moechte astrsent ianste ioarnst arst rt ar.",
    requestTS: "Mon 11.",
    pingType: PingType.incoming,
    responses: [
      PingResponse(
        response: "ja, bitte.",
        responseTS: "Sun 20.",
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
    return ListView(
      children: _pings.map(
        (ping) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TPStyledListTile(
              // leading: Image.asset("assets/images/logo_2of3.png"),
              leading: Hero(
                child: trustpingLogo3of3,
                tag: ping.request,
              ),
              titleString: pingTitle(ping),
              trailingString: ping.requestTS,
              subtitleString: ping.request,
              onTap: () => ExtendedNavigator.of(context).pushNamed(
                  Routes.pingPage,
                  arguments: PingPageArguments(ping: ping)),
            ),
          );
        },
      ).toList(),
    );
  }
}

String pingTitle(Ping ping) {
  return (ping.pingType == PingType.outgoing) ? "Dein Ping" : "Anfrage";
}
