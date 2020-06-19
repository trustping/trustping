import 'package:flutter/material.dart';

class PingsTab extends StatelessWidget {
  const PingsTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InputChip(
                label: Text("Pings"),
                onSelected: (val) {},
              ),
              InputChip(
                label: Text("Matching"),
                onSelected: (val) {},
              )
            ],
          ),
        ),
        ListTile(title: Text("Ping1 2020-06-13 ... ")),
        ListTile(title: Text("Ping1 2020-05-13 ... ")),
        ListTile(title: Text("Ping1 2020-04-13 ... ")),
      ],
    );
  }
}
