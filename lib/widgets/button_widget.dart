import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/utils/styles.dart';

class ButtonWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final double iconPadding;
  final Function onPressed;

  ButtonWidget(
      {@required this.title,
      @required this.icon,
      @required this.onPressed,
      this.iconPadding = 12.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RawMaterialButton(
          fillColor: listItemBackgroundColor,
          shape: CircleBorder(),
          padding: EdgeInsets.all((iconPadding)),
          onPressed: onPressed,
          child: icon,
        ),
        SizedBox(height: 10.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: listItemBackgroundColor),
        )
      ],
    );
  }
}
