import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';
import 'package:trust_ping_app/app/onboarding/diagnosis_forms.dart';
import 'package:trust_ping_app/app/onboarding/living_situation_forms.dart';
import 'package:trust_ping_app/app/onboarding/therapy_forms.dart';
import 'package:trust_ping_app/app/spaces.dart';
import 'package:trust_ping_app/common_widgets/avatar.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/common_widgets/platform_alert_dialog.dart';
import 'package:trust_ping_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key key}) : super(key: key);
  static final editIcon = Icon(Icons.edit, color: Style.textLightColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildProfileDataArea(context),
      ],
    );
  }

  Widget _buildProfileDataArea(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: true);

    return StreamBuilder<UserProfileV2>(
      stream: db.userProfileV2Stream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final profile = snapshot.data;
          final _onNext = () => Navigator.of(context).pop();

          return Expanded(
            child: ListView(
              padding: EdgeInsets.all(24),
              children: <Widget>[
                Text("TODO move this button"),
                _buildActionArea(context),
                vspace16,
                Divider(),
                vspace16,
                _bulidNameYearHeader(context, profile),
                _buildSection(
                  context,
                  "Tumorart",
                  profile.diagnosisCancerType,
                  Style.reds,
                  profile,
                  () => DiagnosisCancerForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context,
                  "Diagnose/Eigenschaften",
                  profile.diagnosisCancerProperties,
                  Style.reds,
                  profile,
                  () => DiagnosisPropertiesForm(
                      profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context,
                  "Krankheitsphase",
                  profile.diagnosisPhase,
                  Style.reds,
                  profile,
                  () => DiagnosisPhaseForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context,
                  "Therapie",
                  profile.therapyMethods,
                  Style.blues,
                  profile,
                  () => TherapyMethodForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context,
                  "Nebenwirkungen",
                  profile.therapySideEffects,
                  Style.blues,
                  profile,
                  () =>
                      TherapySideEffectForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context,
                  "Situation",
                  profile.situationGeneral,
                  Style.yellows,
                  profile,
                  () => LivingSituationForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context,
                  "Interessen",
                  profile.situationInterests,
                  Style.yellows,
                  profile,
                  () => LivingSituationInterestsForm(
                      profile: profile, onNext: _onNext),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _bulidNameYearHeader(BuildContext context, UserProfileV2 profile) {
    final editButton = IconButton(
      icon: editIcon,
      onPressed: () {
        Flushbar(
          message: 'TODO not implemented yet',
          duration: Duration(seconds: 3),
        ).show(context);
      },
    );
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TPCircleAvatarWithBorder(
              radius: 28,
              child: Text(profile.name[0]),
              borderColor: Style.red,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Style.title(profile.name),
                  editButton,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Style.subtitle(profile.yearOfBirth.toString()),
                  editButton,
                ],
              ),
            ],
          ),
        ),
      ],
    );
    return ListTile(
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
          editButton,
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Style.subtitle(profile.yearOfBirth.toString()),
          editButton,
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String name,
    List<Item> items,
    List<Color> colors,
    UserProfileV2 profile,
    Function formBuilder,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
              IconButton(
                icon: Icon(Icons.edit, color: Style.textLightColor),
                onPressed: () {
                  ExtendedNavigator.of(context).pushNamed(
                    Routes.profileEditPage,
                    arguments: ProfileEditPageArguments(
                      title: name,
                      formBuilder: formBuilder,
                    ),
                  );
                },
              ),
            ],
          ),
          _buildWrap(items, colors),
        ],
      ),
    );
  }

  Widget _buildWrap(List<Item> items, List<Color> colors) {
    if (items.length == 0) {
      return Text(
        "Nichts aus­ge­wählt.",
        style: Style.bodyTS.copyWith(color: Style.textLightColor),
      );
    }
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

  // SIGNOUT
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

// =============================================================================
class ProfileEditPage extends StatelessWidget {
  final String title;
  final Function formBuilder;

  const ProfileEditPage({Key key, this.formBuilder, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: <Widget>[
          Style.title(title),
          formBuilder(),
        ],
      ),
    );
  }
}
