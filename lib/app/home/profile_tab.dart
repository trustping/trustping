import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/common_widgets/avatar.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/common_widgets/platform_alert_dialog.dart';
import 'package:trust_ping_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
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
        // _buildActionArea(context),
        _buildProfileDataArea(context),
      ],
    );
  }

  Widget _buildProfileDataArea(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: true);

    final editIcon = Icon(Icons.edit, color: Style.textLightColor);

    return StreamBuilder<UserProfileV2>(
      stream: db.userProfileV2Stream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final profile = snapshot.data;
          return Expanded(
            child: ListView(
              padding: EdgeInsets.all(24),
              children: <Widget>[
                ListTile(
                  leading: TPCircleAvatarWithBorder(
                    radius: 28,
                    child: Text(profile.name[0]),
                    borderColor: Style.red,
                    backgroundColor: Colors.white,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Style.title(profile.name),
                      editIcon,
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Style.subtitle(profile.yearOfBirth.toString()),
                      editIcon,
                    ],
                  ),
                  // trailing: Icon(Icons.edit, color: Style.textLightColor),
                ),
                _buildSection(
                    "Tumorart", profile.diagnosisCancerType, Style.reds),
                _buildSection("Diagnose/Eigenschaften",
                    profile.diagnosisCancerProperties, Style.reds),
                _buildSection(
                    "Krankheitsphase", profile.diagnosisPhase, Style.reds),
                _buildSection("Therapie", profile.therapyMethods, Style.blues),
                _buildSection(
                    "Nebenwirkungen", profile.therapySideEffects, Style.blues),
                _buildSection(
                    "Situation", profile.situationGeneral, Style.yellows),
                _buildSection(
                    "Interessen", profile.situationInterests, Style.yellows),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildSection(String name, List<Item> items, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
              Icon(Icons.edit, color: Style.textLightColor),
            ],
          ),
          _buildWrap(items, colors),
        ],
      ),
    );
  }

  Wrap _buildWrap(List<Item> items, List<Color> colors) {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: items.map((item) {
        return TPFilterChip(
          label: item.text,
          selected: true,
          colors: colors,
        );
      }).toList(),
    );
  }

  RaisedButton _buildActionArea(BuildContext context) {
    return RaisedButton(
      color: Style.yellow,
      child: Text(
        Strings.logout,
        style: TextStyle(
          fontSize: 18.0,
          // color: Theme.of(context).accentColor,
        ),
      ),
      onPressed: () => _confirmSignOut(context),
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
