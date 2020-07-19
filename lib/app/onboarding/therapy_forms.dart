import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart' as UP;
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';
import 'package:trust_ping_app/utils.dart';

// =============================================================================
class TherapyMethodForm extends StatefulWidget {
  final UP.UserProfileV2 profile;
  final Function onNext;

  const TherapyMethodForm(
      {Key key, @required this.profile, @required this.onNext})
      : assert(profile != null),
        super(key: key);

  @override
  _TherapyMethodFormState createState() => _TherapyMethodFormState();
}

class _TherapyMethodFormState extends State<TherapyMethodForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.THERAPY_METHODS;
  Set<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _selectedIDs = widget.profile.therapyMethodsIDs.toSet();
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
    // TODO extract logic into class independent function
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map((UP.Item item) {
        return TPFilterChip(
          label: item.text,
          selected: _selectedIDs.contains(item.id),
          colors: Style.blues,
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
    var ids = Set.from(listify(_selectedIDs));
    return widget.profile.copyWith(
      therapyMethods: _options.where((item) => ids.contains(item.id)).toList(),
    );
  }
}

// =============================================================================
class TherapySideEffectForm extends StatefulWidget {
  final UP.UserProfileV2 profile;
  final Function onNext;

  const TherapySideEffectForm(
      {Key key, @required this.profile, @required this.onNext})
      : assert(profile != null),
        super(key: key);

  @override
  _TherapySideEffectFormState createState() => _TherapySideEffectFormState();
}

class _TherapySideEffectFormState extends State<TherapySideEffectForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.THERAPY_SIDE_EFFECTS;
  Set<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _selectedIDs = widget.profile.therapySideEffectsIDs.toSet();
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
    // TODO extract logic into class independent function
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map((UP.Item item) {
        return TPFilterChip(
          label: item.text,
          selected: _selectedIDs.contains(item.id),
          colors: Style.blues,
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
    var ids = Set.from(listify(_selectedIDs));
    return widget.profile.copyWith(
      therapySideEffects:
          _options.where((item) => ids.contains(item.id)).toList(),
    );
  }
}
