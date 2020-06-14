import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/common_widgets/avatar.dart';
import 'package:trust_ping_app/common_widgets/list_items_builder.dart';
import 'package:trust_ping_app/common_widgets/platform_alert_dialog.dart';
import 'package:trust_ping_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';

import 'models/chat.dart';
import 'models/user.dart';

// Show an active conversation
class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trustping Chat"),
        actions: _buildActions(context),
      ),
      body: _buildBody(context, _selectedIndex),
      // body: _widgets.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ExtendedNavigator.of(context).pushNamed(Routes.composePingPage),
        child: Icon(Icons.person_add),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      // IconButton(
      //   icon: Icon(Icons.account_circle),
      //   onPressed: () {
      //     ExtendedNavigator.of(context).pushNamed(Routes.accountPage);
      //   },
      // ),
      IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          ExtendedNavigator.of(context).pushNamed(
            Routes.introductionPage,
            arguments: IntroductionPageArguments(
              onDone: () => ExtendedNavigator.of(context)
                  .popAndPushNamed(Routes.chatsPage),
            ),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.account_box),
        onPressed: () {
          ExtendedNavigator.of(context).pushNamed(Routes.userProfilePage);
        },
      ),
      IconButton(
        icon: Icon(Icons.all_inclusive),
        onPressed: () {
          ExtendedNavigator.of(context).pushNamed(Routes.uoNamePage);
        },
      ),
    ];
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Chat"),
          icon: Icon(Icons.chat_bubble),
        ),
        BottomNavigationBarItem(
          title: Text("Ping"),
          icon: Icon(Icons.check),
        ),
        BottomNavigationBarItem(
          title: Text("Profil"),
          icon: Icon(Icons.person),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Style.red,
      onTap: _onItemTapped,
    );
  }

  Widget _buildBody(BuildContext context, int widgetIndex) {
    if (widgetIndex == 1) {
      return Column(
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InputChip(
                  label: Text("Pings"),
                  onSelected: (val) {},
                ),
                InputChip(
                  label: Text("Matching"),
                  onSelected: (val) {},
                )
              ],
            ),
          ),
          ListTile(title: Text("Ping1 2020-06-13 ... ")),
          ListTile(title: Text("Ping1 2020-05-13 ... ")),
          ListTile(title: Text("Ping1 2020-04-13 ... ")),
        ],
      );
    } else if (widgetIndex == 2) {
      return ProfileWidget();
    }

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

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        vspace32,
        vspace32,
        Text("TODO Profile Widget"),
        vspace32,
        RaisedButton(
          color: Style.yellow,
          child: Text(
            Strings.logout,
            style: TextStyle(
              fontSize: 18.0,
              // color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () => _confirmSignOut(context),
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final FirebaseAuthService auth =
          Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
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
