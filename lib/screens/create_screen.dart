import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit/cubit/create/create_cubit.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';
import 'package:habit/widgets/button_widget.dart';
import 'package:habit/widgets/habit_text_field_widget.dart';

class CreateScreen extends StatefulWidget {
  static const String id = "create_screen";

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int notificationTime;
  String imageUrl = "images/cat.svg";
  final habitTitleController = TextEditingController();

  void createHabit(String title, String imageUrl, int notificationTime) {
    if (title != null) {
      if (title.isNotEmpty) {
        print("title is not empty");
        Habit habit = Habit(name: title, imageUrl: imageUrl);
        final createCubit = BlocProvider.of<CreateCubit>(context);
        createCubit.create(habit);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCubit, CreateState>(
        listener: (consumerContext, state) {
          if (state is CreateFinished) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: blurredColor,
          child: Container(
            decoration: BoxDecoration(
              color: createBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  right: 40.0, left: 40.0, top: 45.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  HabitTextFieldWidget(
                    controller: habitTitleController,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonWidget(
                        onPressed: () {
                          //call timePicker
                        },
                        title: NOTIFICATION,
                        icon: Icon(
                          Icons.notifications,
                          size: 28.0,
                          color: Colors.black,
                        ),
                        iconPadding: 10.0,
                      ),
                      ButtonWidget(
                        onPressed: () {
                          //implement image selection
                        },
                        title: CHOOSE_ICON,
                        icon: Icon(
                          FontAwesomeIcons.solidHandRock,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      String title = habitTitleController.text;
                      print("FAB Pressed, title:$title");
                      createHabit(title, imageUrl, notificationTime);
                    },
                    child: Icon(Icons.check),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    habitTitleController.dispose();
    super.dispose();
  }
}
