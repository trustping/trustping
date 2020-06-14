import 'package:flutter/material.dart';
import 'package:trust_ping_app/theme.dart';

@immutable
class TPButton extends StatelessWidget {
  const TPButton({
    Key key,
    @required this.child,
    this.color,
    this.textColor,
    this.height = 36.0,
    this.width = 180.0,
    this.borderRadius = 4.0,
    this.onPressed,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FlatButton(
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        color: color,
        disabledColor: color,
        textColor: textColor,
        onPressed: onPressed,
      ),
    );
  }

  static primary({
    Key key,
    String text,
    onPressed,
    width = 180.0,
  }) {
    return TPButton(
      child: Style.body(text),
      onPressed: onPressed,
      color: Style.yellow,
      width: width,
      borderRadius: 4.0,
    );
  }

  static secondary({
    Key key,
    String text,
    onPressed,
    width = 180.0,
  }) {
    return TPButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      onPressed: onPressed,
      textColor: Style.textLightColor,
      width: width,
      borderRadius: 4.0,
    );
  }
}
