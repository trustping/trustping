import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/common_widgets/platform_alert_dialog.dart';
import 'package:trust_ping_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/theme.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        vspace32,
        vspace32,
        vspace32,
        vspace32,
        Center(child: Text("TODO Profil Details + Bearbeiten")),
        vspace32,
        vspace32,
        vspace32,
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
