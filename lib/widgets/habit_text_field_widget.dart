import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';

class HabitTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  HabitTextFieldWidget({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: Colors.white, backgroundColor: createBackgroundColor),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.white),
          labelText: HABIT,
          hintText: ENTER_HABIT,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }
}
