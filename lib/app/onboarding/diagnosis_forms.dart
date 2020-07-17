import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart'
    as UserProfile;
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/theme.dart';

// =============================================================================
class DiagnosisCancerForm extends StatefulWidget {
  final Function onNext;
  const DiagnosisCancerForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _DiagnosisCancerFormState createState() => _DiagnosisCancerFormState();
}

class _DiagnosisCancerFormState extends State<DiagnosisCancerForm> {
  final key = GlobalKey<FormState>();

  final List<UserProfile.Item> _options = UserProfile.CANCER_TYPES;
  String _selectedID = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            // value: _cancerType,
            onChanged: (String value) {
              setState(() => _selectedID = value);
            },
            onSaved: (String value) {
              setState(() => _selectedID = value);
            },
            items: _options.map((UserProfile.Item item) {
              return DropdownMenuItem<String>(
                value: item.id,
                child: Text(item.text),
              );
            }).toList(),
            isExpanded: true,
          ),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                widget.onNext();
              }
            },
            onSkip: () => widget.onNext(),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}

// =============================================================================
class DiagnosisPropertiesForm extends StatefulWidget {
  final Function onNext;
  const DiagnosisPropertiesForm({Key key, @required this.onNext})
      : super(key: key);

  @override
  _DiagnosisPropertiesFormState createState() =>
      _DiagnosisPropertiesFormState();
}

class _DiagnosisPropertiesFormState extends State<DiagnosisPropertiesForm> {
  final key = GlobalKey<FormState>();

  final List<UserProfile.Item> _options = UserProfile.CANCER_PROPERTIES;
  Set<String> _selectedIDs = Set();

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
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                widget.onNext();
              }
            },
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
        (UserProfile.Item item) {
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
}

// =============================================================================
class DiagnosisPhaseForm extends StatefulWidget {
  final Function onNext;
  const DiagnosisPhaseForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _DiagnosisPhaseFormState createState() => _DiagnosisPhaseFormState();
}

class _DiagnosisPhaseFormState extends State<DiagnosisPhaseForm> {
  final key = GlobalKey<FormState>();

  final List<UserProfile.Item> _options = UserProfile.CANCER_PHASES;
  Set<String> _selectedIDs = Set();

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
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                widget.onNext();
              }
            },
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
        (UserProfile.Item item) {
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
}
