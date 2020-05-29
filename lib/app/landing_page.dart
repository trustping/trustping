import 'package:auto_route/auto_route.dart';
import 'package:trust_ping_app/app/home/chats_page.dart';
import 'package:trust_ping_app/app/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/routing/router.gr.dart';

import 'home/models/user.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
///
/// Check out main.dart for an explanation of the widget tree.
class LandingPage extends StatefulWidget {
  const LandingPage({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _introPagesCompleted = false;

  @override
  Widget build(BuildContext context) {
    // if (_introPagesCompleted == false) {
    //   ExtendedNavigator.of(context).pushNamed(Routes.introductionPage);
    // } else {
    if (widget.userSnapshot.connectionState == ConnectionState.active) {
      return widget.userSnapshot.hasData ? ChatsPage() : SignInPageBuilder();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // }
  }
}
