import 'package:trust_ping_app/app/home/chats_page.dart';
import 'package:trust_ping_app/app/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

import 'home/models/user.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
///
/// Check out main.dart for an explanation of the widget tree.
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? ChatsPage() : SignInPageBuilder();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
