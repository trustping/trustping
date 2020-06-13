import 'package:flutter/material.dart';

class TPFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final List<Color> colors;

  const TPFilterChip(
      {Key key, this.label, this.selected, this.onSelected, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 4),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        onSelected: onSelected,
        showCheckmark: false,
        selectedColor: colors.first,
        backgroundColor: colors.last,
      ),
    );
  }
}
