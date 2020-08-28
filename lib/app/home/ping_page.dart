import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/pings_tab.dart';
import 'package:trust_ping_app/common_widgets/spaces.dart';
import 'package:trust_ping_app/common_widgets/avatar.dart';
import 'package:trust_ping_app/tpstyle.dart';

class PingPage extends StatelessWidget {
  const PingPage({Key key, @required this.ping}) : super(key: key);
  final Ping ping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ping"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.all(16),
      children: <Widget>[
        vspace32,
        // Style.title("Dein Ping"),
        Column(
          children: <Widget>[
            _buildRequest(),
            vspace32,
            vspace16,
            _buildResponses(context),
          ],
        ),
      ],
    );
  }

  Widget _buildRequest() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Text(
              ping.requestTS,
              style: TPStyle.tinyTS.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
          TPStyle.title(ping.subject),
          vspace8,
          vspace16,
          TPStyle.body(ping.request),
        ],
      ),
    );
  }

  Widget _buildResponses(BuildContext context) {
    final responses = ping.responses;
    if (ping.pingType == PingType.incoming) {
      if (responses.length == 0) {
        return _buildButtonsForIncomingPing();
      } else {
        // return Text("TODO View response");
        return Column(
          children: responses.map(
            (response) {
              return Column(
                children: [
                  _buildSingleResponse(response),
                  vspace8,
                  if (response.pingState == PingState.pong)
                    Text("Warte auf Bestaetigung..."),
                  if (response.pingState == PingState.done)
                    Text("TODO Jump to Chat"),
                  vspace8,
                ],
              );
            },
          ).toList(),
        );
      }
    } else {
      if (responses.length == 0) {
        return Column(
          children: <Widget>[
            vspace8,
            TPStyle.tiny("Warte auf Antworten..."),
            vspace16,
          ],
        );
      }
      return Column(
        children: responses.map(
          (response) {
            return Column(
              children: [
                _buildSingleResponse(response),
                _buildButtonsForOutgoingPing(response),
                vspace16,
              ],
            );
          },
        ).toList(),
      );
    }
  }

  Widget _buildSingleResponse(PingResponse response) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TPCircleAvatarWithBorder(
            borderColor: TPStyle.red,
            backgroundColor: TPStyle.blue,
            radius: 20,
            child: Text("P"),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            color: TPStyle.lightGray,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      response.authorName,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TPStyle.tiny(ping.requestTS),
                  ],
                ),
                Text(response.response),
              ],
            ),
          ),
        ),
      ],
    );
    // return ListTile(
    //   leading: TPCircleAvatarWithBorder(
    //     borderColor: Style.red,
    //     backgroundColor: Style.blue,
    //     radius: 20,
    //     child: Text("P"),
    //   ),
    //   title: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         "Von Hella",
    //         style: Style.bodyTS
    //             .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
    //       ),
    //       Text(
    //         response.responseTS,
    //         style: TextStyle(color: Style.blue),
    //       )
    //     ],
    //   ),
    //   subtitle: Text(
    //     response.response,
    //     style: Style.bodyTS.copyWith(fontSize: 16),
    //   ),
    // );
  }

  Widget _buildButtonsForIncomingPing() {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("loeschen"),
          textColor: TPStyle.textLightColor,
        ),
        FlatButton(
          onPressed: () {},
          child: Text("antworten"),
          textColor: TPStyle.blue,
        ),
      ],
    );
  }

  Widget _buildButtonsForOutgoingPing(PingResponse response) {
    if (response.pingState == PingState.pong) {
      return ButtonBar(
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text("loeschen"),
            textColor: TPStyle.textLightColor,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Chat beginnen"),
            textColor: TPStyle.blue,
          ),
        ],
      );
    }
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            "zum Chat",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          textColor: TPStyle.blue,
        ),
      ],
    );
  }
}
