import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart' as UP;
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';
import 'package:trust_ping_app/utils.dart';

// =============================================================================
class DiagnosisCancerForm extends StatefulWidget {
  final Function onNext;
  final UP.UserProfileV2 profile;
  const DiagnosisCancerForm({
    Key key,
    @required this.profile,
    @required this.onNext,
  })  : assert(profile != null),
        super(key: key);

  @override
  _DiagnosisCancerFormState createState() => _DiagnosisCancerFormState();
}

class _DiagnosisCancerFormState extends State<DiagnosisCancerForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.CANCER_TYPES;
  String _selectedID;

  @override
  void initState() {
    super.initState();
    _selectedID = (widget.profile.diagnosisCancerType.length == 0)
        ? null
        : widget.profile.diagnosisCancerType.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _selectedID,
            onChanged: (String value) {
              setState(() => _selectedID = value);
            },
            onSaved: (String value) {
              setState(() => _selectedID = value);
            },
            items: _options.map((UP.Item item) {
              return DropdownMenuItem<String>(
                value: item.id,
                child: Text(item.text),
              );
            }).toList(),
            isExpanded: true,
          ),
          buildButtonNav(
            context: context,
            onNext: _submit,
            onSkip: () => widget.onNext(),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
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

  UserProfileV2 _userProfileFromState() {
    if (_selectedID == null) {
      return widget.profile;
    }
    return widget.profile.copyWith(
      diagnosisCancerType: UP.CANCER_TYPES
          .where((element) => element.id == _selectedID)
          .toList(),
    );
  }
}

// =============================================================================
class DiagnosisPropertiesForm extends StatefulWidget {
  final UP.UserProfileV2 profile;
  final Function onNext;
  const DiagnosisPropertiesForm({
    Key key,
    @required this.profile,
    @required this.onNext,
  })  : assert(profile != null),
        super(key: key);

  @override
  _DiagnosisPropertiesFormState createState() =>
      _DiagnosisPropertiesFormState();
}

class _DiagnosisPropertiesFormState extends State<DiagnosisPropertiesForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.CANCER_PROPERTIES;
  Set<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _selectedIDs = listify<Item>(widget.profile.diagnosisCancerProperties)
        .map((e) => e.id)
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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

  Widget _buildChips() {
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map(
        (UP.Item item) {
          return TPFilterChip(
            label: item.text,
            selected: _selectedIDs.contains(item.id),
            onSelected: (bool selected) {
              setState(() {
                selected
                    ? _selectedIDs.add(item.id)
                    : _selectedIDs.remove(item.id);
              });
            },
            colors: Style.reds,
          );
        },
      ).toList(),
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
      diagnosisCancerProperties: UP.CANCER_PROPERTIES
          .where((element) => ids.contains(element.id))
          .toList(),
    );
  }
}

// =============================================================================
class DiagnosisPhaseForm extends StatefulWidget {
  final UP.UserProfileV2 profile;
  final Function onNext;
  const DiagnosisPhaseForm({
    Key key,
    @required this.profile,
    @required this.onNext,
  })  : assert(profile != null),
        super(key: key);

  @override
  _DiagnosisPhaseFormState createState() => _DiagnosisPhaseFormState();
}

class _DiagnosisPhaseFormState extends State<DiagnosisPhaseForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.CANCER_PHASES;
  Set<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _selectedIDs =
        listify<Item>(widget.profile.diagnosisPhase).map((e) => e.id).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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

  Widget _buildChips() {
    // TODO extract logic into class independent function
    return Wrap(
      runSpacing: -8,
      spacing: 8,
      children: _options.map(
        (UP.Item item) {
          return TPFilterChip(
            label: item.text,
            selected: _selectedIDs.contains(item.id),
            onSelected: (bool selected) {
              setState(() {
                selected
                    ? _selectedIDs.add(item.id)
                    : _selectedIDs.remove(item.id);
              });
            },
            colors: Style.reds,
          );
        },
      ).toList(),
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

  UserProfileV2 _userProfileFromState() {
    var ids = Set.from(listify(_selectedIDs));
    return widget.profile.copyWith(
      diagnosisPhase: UP.CANCER_PHASES
          .where((element) => ids.contains(element.id))
          .toList(),
    );
    //
  }
}
