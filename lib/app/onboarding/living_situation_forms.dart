import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart' as UP;
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';
import 'package:trust_ping_app/utils.dart';

// =============================================================================
class LivingSituationForm extends StatefulWidget {
  final UP.UserProfileV2 profile;
  final Function onNext;

  const LivingSituationForm(
      {Key key, @required this.profile, @required this.onNext})
      : assert(profile != null),
        super(key: key);

  @override
  _LivingSituationFormState createState() => _LivingSituationFormState();
}

class _LivingSituationFormState extends State<LivingSituationForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.SITUATION_GENERAL;
  Set<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _selectedIDs = widget.profile.situationGeneralIDs.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: _submit,
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map((UP.Item item) {
        return TPFilterChip(
          label: item.text,
          selected: _selectedIDs.contains(item.id),
          colors: Style.yellows,
          onSelected: (bool selected) {
            setState(() => selected
                ? _selectedIDs.add(item.id)
                : _selectedIDs.remove(item.id));
          },
        );
      }).toList(),
    );
  }

  void _submit() {
    final form = this.key.currentState;
    if (form.validate()) {
      setState(() => form.save());

      final db = Provider.of<FirestoreDatabase>(context, listen: false);
      db.setUserProfileV2(_userProfileFromState());

      widget.onNext();
    }
  }

  UP.UserProfileV2 _userProfileFromState() {
    final ids = Set.from(listify(_selectedIDs));
    return widget.profile.copyWith(
      situationGeneral:
          _options.where((item) => ids.contains(item.id)).toList(),
    );
  }
}

// =============================================================================
class LivingSituationInterestsForm extends StatefulWidget {
  final UP.UserProfileV2 profile;
  final Function onNext;

  const LivingSituationInterestsForm(
      {Key key, @required this.profile, @required this.onNext})
      : assert(profile != null),
        super(key: key);

  @override
  _LivingSituationInterestsFormState createState() =>
      _LivingSituationInterestsFormState();
}

class _LivingSituationInterestsFormState
    extends State<LivingSituationInterestsForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.SITUATION_INTERESTS;
  Set<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _selectedIDs = listify<UP.Item>(widget.profile.situationGeneral)
        .map((e) => e.id)
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: _submit,
            onNextButtonText: Strings.ok,
            onSkip: () => widget.onNext(),
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map((UP.Item item) {
        return TPFilterChip(
          label: item.text,
          selected: _selectedIDs.contains(item.id),
          colors: Style.yellows,
          onSelected: (bool selected) {
            setState(() => selected
                ? _selectedIDs.add(item.id)
                : _selectedIDs.remove(item.id));
          },
        );
      }).toList(),
    );
  }

  void _submit() {
    final form = this.key.currentState;
    if (form.validate()) {
      setState(() => form.save());

      final db = Provider.of<FirestoreDatabase>(context, listen: false);
      db.setUserProfileV2(_userProfileFromState());

      widget.onNext();
    }
  }

  UP.UserProfileV2 _userProfileFromState() {
    final ids = Set.from(listify(_selectedIDs));
    return widget.profile.copyWith(
      situationInterests:
          _options.where((item) => ids.contains(item.id)).toList(),
    );
  }
}
