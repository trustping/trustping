import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart' as UP;
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/theme.dart';

// =============================================================================
class TherapyTherapyForm extends StatefulWidget {
  final Function onNext;
  const TherapyTherapyForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _TherapyTherapyFormState createState() => _TherapyTherapyFormState();
}

class _TherapyTherapyFormState extends State<TherapyTherapyForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.THERAPY_METHODS;
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
}

// =============================================================================
class TherapySideEffectForm extends StatefulWidget {
  final Function onNext;
  const TherapySideEffectForm({Key key, @required this.onNext})
      : super(key: key);

  @override
  _TherapySideEffectFormState createState() => _TherapySideEffectFormState();
}

class _TherapySideEffectFormState extends State<TherapySideEffectForm> {
  final key = GlobalKey<FormState>();

  final List<UP.Item> _options = UP.THERAPY_SIDE_EFFECTS;
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
}
