import 'dart:html' as prefix0;

import 'package:flutter_web/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final double borderRadius;
  final VoidCallback onPressed;

  RoundedButton(
      {@required this.title, this.borderRadius = 12.0, this.onPressed})
      : assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textTheme: ButtonTextTheme.normal,
      child: Text(title),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      onPressed: () => print('sa'),
    );
  }
}
