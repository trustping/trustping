import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/chats_tab.dart';
import 'package:trust_ping_app/app/home/pings_tab.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/common_widgets/avatar.dart';
import 'package:trust_ping_app/common_widgets/images.dart';
import 'package:trust_ping_app/theme.dart';

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
        Card(
          child: Column(
            children: <Widget>[
              _buildRequest(),
              vspace32,
              Divider(
                color: Colors.black,
                height: 2,
              ),
              vspace16,
              _buildResponses(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequest() {
    return TPStyledListTile(
      leading: Hero(
        child: trustpingLogo3of3,
        tag: ping.request,
      ),
      titleString: pingTitle(ping),
      trailingString: ping.requestTS,
      subtitleString: ping.request,
      onTap: null,
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
                  vspace16,
                  if (response.pingState == PingState.pong)
                    Text("Warte auf Bestaetigung..."),
                  if (response.pingState == PingState.done)
                    Text("TODO Jump to chat"),
                  vspace16,
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
            vspace16,
            Center(child: Text("Noch keine Antworten...")),
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
                Divider(
                  color: Colors.black,
                  height: 2,
                ),
                vspace16,
              ],
            );
          },
        ).toList(),
      );
    }
  }

  ListTile _buildSingleResponse(PingResponse response) {
    return ListTile(
      leading: TPCircleAvatarWithBorder(
        borderColor: Style.red,
        backgroundColor: Style.blue,
        radius: 20,
        child: Text("P"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Von Hella",
            style: Style.bodyTS
                .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            response.responseTS,
            style: TextStyle(color: Style.blue),
          )
        ],
      ),
      subtitle: Text(
        response.response,
        style: Style.bodyTS.copyWith(fontSize: 16),
      ),
    );
  }

  Widget _buildButtonsForIncomingPing() {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("LOESCHEN"),
          textColor: Style.textLightColor,
        ),
        FlatButton(
          onPressed: () {},
          child: Text("ANTWORTEN"),
          textColor: Style.blue,
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
            child: Text("LOESCHEN"),
            textColor: Style.textLightColor,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("CHAT BEGINNEN"),
            textColor: Style.blue,
          ),
        ],
      );
    }
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            "ZUM CHAT",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          textColor: Style.blue,
        ),
      ],
    );
  }
}
