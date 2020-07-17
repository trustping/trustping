import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart' as UP;
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

// =============================================================================
class LivingSituationForm extends StatefulWidget {
  final Function onNext;
  const LivingSituationForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _LivingSituationFormState createState() => _LivingSituationFormState();
}

class _LivingSituationFormState extends State<LivingSituationForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.SITUATION_GENERAL;
  Set<String> _selectedIDs = Set();

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
}

// =============================================================================
class LivingSituationInterestsForm extends StatefulWidget {
  final Function onNext;
  const LivingSituationInterestsForm({Key key, @required this.onNext})
      : super(key: key);

  @override
  _LivingSituationInterestsFormState createState() =>
      _LivingSituationInterestsFormState();
}

class _LivingSituationInterestsFormState
    extends State<LivingSituationInterestsForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.SITUATION_INTERESTS;
  Set<String> _selectedIDs = Set();

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
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                widget.onNext();
              }
            },
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
}
