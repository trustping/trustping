import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';
import 'package:trust_ping_app/app/onboarding/diagnosis_forms.dart';
import 'package:trust_ping_app/app/onboarding/living_situation_forms.dart';
import 'package:trust_ping_app/app/onboarding/therapy_forms.dart';
import 'package:trust_ping_app/app/onboarding/user_onboarding_page.dart';
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
                _bulidNameYearHeader(context, profile, _onNext),
                _buildSection(
                  context: context,
                  name: "Tumorart",
                  items: profile.diagnosisCancerType,
                  colors: Style.reds,
                  profile: profile,
                  formBuilder: () =>
                      DiagnosisCancerForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context: context,
                  name: "Diagnose/Eigenschaften",
                  items: profile.diagnosisCancerProperties,
                  colors: Style.reds,
                  profile: profile,
                  formBuilder: () => DiagnosisPropertiesForm(
                      profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context: context,
                  name: "Krankheitsphase",
                  items: profile.diagnosisPhase,
                  colors: Style.reds,
                  profile: profile,
                  formBuilder: () =>
                      DiagnosisPhaseForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context: context,
                  name: "Therapie",
                  items: profile.therapyMethods,
                  colors: Style.blues,
                  profile: profile,
                  formBuilder: () =>
                      TherapyMethodForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context: context,
                  name: "Nebenwirkungen",
                  items: profile.therapySideEffects,
                  colors: Style.blues,
                  profile: profile,
                  formBuilder: () =>
                      TherapySideEffectForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context: context,
                  name: "Situation",
                  items: profile.situationGeneral,
                  colors: Style.yellows,
                  profile: profile,
                  formBuilder: () =>
                      LivingSituationForm(profile: profile, onNext: _onNext),
                ),
                _buildSection(
                  context: context,
                  name: "Interessen",
                  items: profile.situationInterests,
                  colors: Style.yellows,
                  profile: profile,
                  formBuilder: () => LivingSituationInterestsForm(
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

  Widget _bulidNameYearHeader(
    BuildContext context,
    UserProfileV2 profile,
    Function onNext,
  ) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TPCircleAvatarWithBorder(
              radius: 28,
              child: Text((profile.name.length > 0) ? profile.name[0] : "?"),
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
                  _formatProfileName(profile),
                  _buildEditButton(
                    context: context,
                    name: "Name",
                    formBuilder: () =>
                        UserNameForm(profile: profile, onNext: onNext),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _formatYearOfBirth(profile),
                  _buildEditButton(
                    context: context,
                    name: "Geburtsjahr",
                    formBuilder: () =>
                        UserAgeForm(profile: profile, onNext: onNext),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    BuildContext context,
    String name,
    List<Item> items,
    List<Color> colors,
    UserProfileV2 profile,
    Function formBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
              _buildEditButton(
                context: context,
                name: name,
                formBuilder: formBuilder,
              ),
            ],
          ),
          _buildWrap(items, colors),
        ],
      ),
    );
  }

  IconButton _buildEditButton({
    BuildContext context,
    String name,
    Function formBuilder,
  }) {
    return IconButton(
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

  Text _formatProfileName(UserProfileV2 profile) {
    return (profile.name.length > 0)
        ? Style.title(profile.name)
        : Text(
            "Kein Name",
            style: Style.titleTS.copyWith(color: Style.textLightColor),
          );
  }

  Text _formatYearOfBirth(UserProfileV2 profile) {
    return (profile.yearOfBirth != null)
        ? Style.subtitle(profile.yearOfBirth.toString())
        : Text(
            "Kein Geburtsjahr",
            style: Style.subtitleTS.copyWith(color: Style.textLightColor),
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
/// Edit a simple section
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
          vspace32,
          formBuilder(),
        ],
      ),
    );
  }
}
