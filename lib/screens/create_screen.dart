import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit/cubit/habits/habits_cubit.dart';
import 'package:habit/cubit/imagePicker/image_picker_cubit.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/screens/detail_screen.dart';
import 'package:habit/screens/image_picker_screen.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';
import 'package:habit/utils/utils.dart';
import 'package:habit/widgets/button_widget.dart';
import 'package:habit/widgets/habit_text_field_widget.dart';

class CreateScreen extends StatefulWidget {
  static const String id = "create_screen";

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TimeOfDay notificationTime;
  String _iconPath;
  final habitTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<int> createHabit(BuildContext context) async {
    int id;
    String title = habitTitleController.text;
    if (title != null) {
      if (title.isNotEmpty) {
        int timeInSeconds = timeOfDayToSeconds(notificationTime) ?? NOT_SET;
        Habit habit = Habit(
            name: title, imageUrl: _iconPath, notificationTime: timeInSeconds);
        final habitsCubit = BlocProvider.of<HabitsCubit>(context);
        id = await habitsCubit.create(habit);

        DomainHabit domainHabit = habit.toDomainHabit(id);
        await scheduleDailyNotificationTask(domainHabit);
        if (timeInSeconds != NOT_SET) {
          await scheduleReminderNotificationTask(domainHabit);
        }
      }
    }
    return id;
  }

  Future setNotificationTime() async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return child;
        });
    if (time != null) {
      setState(() {
        notificationTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding:
              EdgeInsets.only(right: 40.0, left: 40.0, top: 45.0, bottom: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HabitTextFieldWidget(
                  controller: habitTitleController,
                  formKey: _formKey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonWidget(
                      onPressed: () async {
                        //call timePicker
                        setNotificationTime();
                      },
                      title: notificationTime != null
                          ? displayTime()
                          : NOTIFICATION,
                      icon: Icon(
                        Icons.notifications,
                        size: 28.0,
                        color: Colors.black,
                      ),
                      iconPadding: 10.0,
                    ),
                    ButtonWidget(
                      onPressed: () async {
                        //implement image selection
                        String path = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (BuildContext context) =>
                                        ImagePickerCubit()..initImages(context),
                                    child: ImagePickerScreen())));
                        print("iconPath: $path");
                        if (path != null) {
                          setState(() {
                            _iconPath = path;
                          });
                        }
                      },
                      title: _iconPath == null ? CHOOSE_ICON : ICON_SELECTED,
                      icon: Icon(
                        FontAwesomeIcons.solidHandRock,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                FloatingActionButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      int id = await createHabit(context);
                      print("Created habit's index: $id");
                      if (id != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(id)));
                      }
                      //display snackbar
                    }
                  },
                  child: Icon(Icons.check),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String displayTime() {
    return "Remind \nat ${printTime(notificationTime)}";
  }

  @override
  void dispose() {
    habitTitleController.dispose();
    super.dispose();
  }
}
