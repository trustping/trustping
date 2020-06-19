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
    return StreamBuilder<List<Chat>>(
      stream: db.chatsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Chat>(
          snapshot: snapshot,
          itemBuilder: (context, chat) {
            return ChatListTile(chat: chat);
          },
        );
      },
    );
  }
}

class ChatListTile extends StatelessWidget {
  const ChatListTile({this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final myUserID = Provider.of<User>(context, listen: false).uid;
    final otherParticipant = chat.otherParticipant(myUserID);
    return ListTile(
      leading: CircleAvatarWithBorder(
        child: Text(
          otherParticipant[0].toUpperCase(),
          style: TextStyle(color: Style.red),
        ),
        borderColor: Style.red,
        backgroundColor: Colors.white,
        radius: 25,
      ),
      // title: Text(otherParticipant),
      title: Text(
        "Fake Name Peter",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      // subtitle: Text(chat.id),
      subtitle: Text(
        chat.id,
        style: Style.tinyTS.copyWith(color: Style.textLightColor),
      ),
      trailing: Text(
        "Mon 11.",
        style: Style.tinyTS.copyWith(color: Style.blue),
      ),
      onTap: () {
        ExtendedNavigator.of(context).pushNamed(
          Routes.chatPage,
          arguments: ChatPageArguments(chat: chat),
        );
      },
    );
  }
}
