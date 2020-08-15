import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/chat.dart';
import 'package:trust_ping_app/app/home/models/user.dart';
import 'package:trust_ping_app/common_widgets/avatar.dart';
import 'package:trust_ping_app/common_widgets/list_items_builder.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';

class ChatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final myUserID = Provider.of<User>(context, listen: false).uid;
    return StreamBuilder<List<Chat>>(
      stream: db.chatsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Chat>(
          snapshot: snapshot,
          itemBuilder: (context, chat) {
            return ChatListTile(chat: chat, myUserID: myUserID);
          },
        );
      },
    );
  }
}

class ChatListTile extends StatelessWidget {
  const ChatListTile({this.chat, this.myUserID});
  final Chat chat;
  final String myUserID;

  @override
  Widget build(BuildContext context) {
    final otherParticipant = chat.otherParticipant(myUserID);
    return TPStyledListTile(
      titleString: "Anonym",
      // subtitleString: chat.id,
      subtitleString: "Lorem ipsum dolor sit amet, consetetur",
      trailingString: "Mon 11.",
      onTap: () {
        ExtendedNavigator.of(context).pushNamed(
          Routes.chatPage,
          arguments: ChatPageArguments(chat: chat),
        );
      },
      leading: TPCircleAvatarWithBorder(
        child: Text(
          otherParticipant[0].toUpperCase(),
          style: TextStyle(color: Style.red),
        ),
        borderColor: Style.red,
        backgroundColor: Colors.white,
        radius: 25,
      ),
    );
  }
}

class TPStyledListTile extends StatelessWidget {
  const TPStyledListTile({
    Key key,
    @required this.leading,
    @required this.titleString,
    @required this.subtitleString,
    @required this.trailingString,
    @required this.onTap,
  }) : super(key: key);

  final Widget leading;
  final String titleString;
  final String subtitleString;
  final String trailingString;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final ts = Style.bodyTS;
    return ListTile(
      leading: leading,
      // title: Text(otherParticipant),
      title: Text(
        titleString,
        style: ts.copyWith(fontWeight: FontWeight.w500),
      ),
      // subtitle: Text(chat.id),
      subtitle: Text(
        subtitleString,
        // style: Style.tinyTS.copyWith(color: Style.textLightColor),
        style: ts.copyWith(color: Style.textColor),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            trailingString,
            style: Style.tinyTS.copyWith(color: Style.textLightColor),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
