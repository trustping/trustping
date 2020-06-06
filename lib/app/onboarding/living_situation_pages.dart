import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trust_ping_app/app/onboarding/utils.dart';
import 'package:trust_ping_app/routing/router.gr.dart';
import 'package:trust_ping_app/theme.dart';

Set<String> _options = Set.from(["Single", "Verheiratet", "foo", "xxx"]);

class UOLivingSituationPage1 extends StatefulWidget {
  @override
  _UOLivingSituationPage1State createState() => _UOLivingSituationPage1State();
}

class _UOLivingSituationPage1State extends State<UOLivingSituationPage1> {
  final key = GlobalKey<FormState>();
  Set<String> _selected = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trustping")),
      body: buildOnboardingContent(
        context: context,
        title: "Lebenssituation",
        subtitle:
            "Erzähl uns noch etwas von Dir. Das hilft uns, die passenden Gesprächspartner für Dich zu finden.",
        header: TPProgressIndicator(
          i: 1,
          n: 2,
          section: "Lebenssituation",
          color: Style.yellow,
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
                    .popAndPushNamed(Routes.uoDiagnosisPage4);
              }
            },
            onBack: () => ExtendedNavigator.of(context)
                .popAndPushNamed(Routes.uoDiagnosisPage4),
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
            selectedColor: Style.yellow,
            backgroundColor: Style.blue,
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
