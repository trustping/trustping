import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/chats_tab.dart';
import 'package:trust_ping_app/app/home/pings_tab.dart';
import 'package:trust_ping_app/app/home/profile_tab.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trustping"),
        actions: _buildActions(context),
      ),
      body: _buildBody(context, _selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          ExtendedNavigator.of(context).pushNamed(Routes.composePingPage),
      child: Icon(Icons.person_add),
    );
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
                  .popAndPushNamed(Routes.mainPage),
            ),
          );
        },
      ),
      // IconButton(
      //   icon: Icon(Icons.account_box),
      //   onPressed: () {
      //     ExtendedNavigator.of(context).pushNamed(Routes.userProfilePage);
      //   },
      // ),
      IconButton(
        icon: Icon(Icons.all_inclusive),
        onPressed: () {
          ExtendedNavigator.of(context).pushNamed(Routes.uoNamePage);
        },
      ),
    ];
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Chat"),
          icon: Icon(Icons.chat_bubble),
        ),
        BottomNavigationBarItem(
          title: Text("Matching"),
          icon: Icon(Icons.check),
        ),
        BottomNavigationBarItem(
          title: Text("Profil"),
          icon: Icon(Icons.person),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Style.red,
      onTap: (int index) => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildBody(BuildContext context, int widgetIndex) {
    switch (widgetIndex) {
      case 0:
        return ChatsTab();
        break;
      case 1:
        return PingsTab();
        break;
      case 2:
        return ProfileTab();
        break;
      default:
        return ChatsTab();
    }
  }
}
