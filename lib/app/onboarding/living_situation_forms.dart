import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/common_widgets/chips.dart';
import 'package:trust_ping_app/constants/strings.dart';
import 'package:trust_ping_app/theme.dart';

class LivingSituationForm extends StatefulWidget {
  final Function onNext;
  const LivingSituationForm({Key key, @required this.onNext}) : super(key: key);

  @override
  _LivingSituationFormState createState() => _LivingSituationFormState();
}

class _LivingSituationFormState extends State<LivingSituationForm> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Single",
    "in Partnerschaft / verheiratet",
    "in Ausbildung / Studium",
    "berufstätig",
    "pensioniert",
    "schwanger",
    "mit Familie",
  ]);

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
      children: _options.map((option) {
        return TPFilterChip(
          label: option,
          selected: _selected.contains(option),
          colors: Style.yellows,
          onSelected: (bool selected) {
            setState(() =>
                selected ? _selected.add(option) : _selected.remove(option));
          },
        );
      }).toList(),
    );
  }
}

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
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Sport",
    "Yoga",
    "Meditation",
    "Entspannung",
    "Ernährung",
    "Job",
    "Selbsthilfe",
    "Reha",
    "Sozialrecht",
    "Politik",
    "Kultur",
    "Kosmetik",
    "Sexualität",
    "Nebenwirkungen",
  ]);

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
      children: _options.map((option) {
        return TPFilterChip(
          label: option,
          selected: _selected.contains(option),
          colors: Style.yellows,
          onSelected: (bool selected) {
            setState(() =>
                selected ? _selected.add(option) : _selected.remove(option));
          },
        );
      }).toList(),
    );
  }
}
