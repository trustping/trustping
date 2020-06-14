import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    @required this.photoUrl,
    @required this.radius,
    this.borderColor,
    this.borderWidth,
  });
  final String photoUrl;
  final double radius;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _borderDecoration(),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black12,
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
        child: photoUrl == null ? Icon(Icons.camera_alt, size: radius) : null,
      ),
    );
  }

  Decoration _borderDecoration() {
    if (borderColor != null && borderWidth != null) {
      return BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      );
    }
    return null;
  }
}

class CircleAvatarWithBorder extends StatelessWidget {
  const CircleAvatarWithBorder({
    Key key,
    @required this.radius,
    @required this.child,
    @required this.borderColor,
    @required this.backgroundColor,
    this.borderWidth = 1,
  }) : super(key: key);

  final double radius;
  final double borderWidth;
  final Color borderColor;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius - borderWidth,
        child: child,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
