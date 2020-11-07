import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';

class HabitTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  HabitTextFieldWidget({
    @required this.controller,
    @required this.formKey,
  });

  @override
  _HabitTextFieldWidgetState createState() => _HabitTextFieldWidgetState();
}

class _HabitTextFieldWidgetState extends State<HabitTextFieldWidget> {
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: Colors.white, backgroundColor: createBackgroundColor),
      child: TextFormField(
        validator: (value) {
          if (value.trim().isEmpty) {
            setState(() {
              isValid = false;
            });
            return 'Please enter habit';
          }

          return null;
        },
        onChanged: (value) {
          if (value.trim().isNotEmpty) {
            if (isValid == false)
              setState(() {
                isValid = true;
              });
            widget.formKey.currentState.validate();
          }
        },
        minLines: 1,
        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle:
                TextStyle(color: isValid ? Colors.white : secondaryColor),
            floatingLabelBehavior: FloatingLabelBehavior.always,
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: secondaryColor),
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: secondaryColor),
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            errorStyle: TextStyle(color: secondaryColor),
            alignLabelWithHint: true),
      ),
    );
  }
}
