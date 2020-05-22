import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/common_widgets/list_items_builder.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

import 'models/chat.dart';
import 'models/user.dart';

// Show an active conversatin
class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TrustPing Chat"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              ExtendedNavigator.of(context).pushNamed(Routes.accountPage);
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              ExtendedNavigator.of(context).pushNamed(Routes.introductionPage);
            },
          ),
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              ExtendedNavigator.of(context).pushNamed(Routes.userProfilePage);
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: () {
          //     ExtendedNavigator.of(context)
          //         .pushNamed(Routes.userInputStepperPage);
          //   },
          // ),
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _createChat(context);
          ExtendedNavigator.of(context).pushNamed(Routes.composePingPage);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
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
      title: Text(otherParticipant),
      leading: CircleAvatar(child: Text(otherParticipant[0])),
      subtitle: Text(chat.id),
      onTap: () {
        ExtendedNavigator.of(context).pushNamed(
          Routes.chatPage,
          arguments: ChatPageArguments(chat: chat),
        );
      },
    );
  }
}
