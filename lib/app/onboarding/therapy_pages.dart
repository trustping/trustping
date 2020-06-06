import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

class UOTherapyPage1 extends StatefulWidget {
  @override
  _UOTherapyPage1State createState() => _UOTherapyPage1State();
}

class _UOTherapyPage1State extends State<UOTherapyPage1> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  final Set<String> _options = Set.from([
    "Chemotherapie",
    "Immuntherapie",
    "Operation",
    "Hormontherapie",
    "Strahlentherapie",
    "Psychotherapie",
    "Komplementäre Medizin",
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Therapie",
        subtitle:
            "Welche Therapien machst Du, hast Du gemacht oder sind geplant?",
        header: TPProgressIndicator(
          i: 1,
          n: 1,
          section: "Lebenssituation",
          colors: Style.blues,
        ),
        form: _buildForm(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: key,
      child: Column(
        children: [
          _buildChips(),
          buildButtonNav(
            context: context,
            onNext: () {
              final form = this.key.currentState;
              if (form.validate()) {
                setState(() => form.save());
                ExtendedNavigator.of(context)
                    .pushNamed(Routes.uoLivingSituationPage1);
              }
            },
          ),
        ],
      ),
    );
  }

  Wrap _buildChips() {
    return Wrap(
      children: _options.map((option) {
        return Container(
          child: FilterChip(
            label: Text(option),
            selected: _selected.contains(option),
            selectedColor: Style.blue,
            backgroundColor: Style.blue50,
            showCheckmark: false,
            onSelected: (bool selected) {
              setState(() =>
                  selected ? _selected.add(option) : _selected.remove(option));
            },
          ),
          padding: EdgeInsets.only(right: 4),
        );
      }).toList(),
    );
  }
}
