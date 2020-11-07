import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/cubit/habits/habits_cubit.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';
import 'package:habit/utils/utils.dart';
import 'package:habit/widgets/custom_progress_widget.dart';

class DetailScreen extends StatefulWidget {
  static const String id = "detail_screen";
  final int habitId;

  DetailScreen(this.habitId);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  AnimationController _progressController;
  AnimationController _sizeController;
  Animation progressAnimation;

  // Animation sizeAnimation;

  Future setNotificationTime(DomainHabit habit, BuildContext context) async {
    if (habit.notificationTime == NOT_SET) {
      TimeOfDay time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return child;
          });

      if (time != null) {
        await updateTime(context, habit, time);
        await scheduleReminderNotificationTask(habit);
      }
    }
  }

  displayTime(int timeInSeconds) {
    TimeOfDay timeOfDay = timeOfDayFromSeconds(timeInSeconds);
    return printTime(timeOfDay);
  }

  DomainHabit getHabit(int id) {
    HabitsCubit cubit = BlocProvider.of<HabitsCubit>(context);
    return cubit.getHabit(id);
  }

  Future updateDays(BuildContext context, DomainHabit habit) async {
    HabitsCubit cubit = BlocProvider.of<HabitsCubit>(context);
    DomainHabit updatedHabit = habit.copyWith(days: habit.days + 1);
    cubit.update(habit.id, updatedHabit);
  }

  Future updateTime(
      BuildContext context, DomainHabit habit, TimeOfDay time) async {
    HabitsCubit cubit = BlocProvider.of<HabitsCubit>(context);
    DomainHabit updatedHabit =
        habit.copyWith(notificationTime: timeOfDayToSeconds(time));
    cubit.update(habit.id, updatedHabit);
  }

  Future<void> deleteHabit(BuildContext context, int id) async {
    print("deleteHabit() called");
    HabitsCubit cubit = BlocProvider.of<HabitsCubit>(context);
    await cubit.delete(id);
    await cancelNotificationTask(id);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // getHabit();
    _progressController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    _sizeController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.decelerate,
      ),
    );
    // progressAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    // sizeAnimation = TweenSequence(
    //   <TweenSequenceItem<double>>[
    //     TweenSequenceItem<double>(tween: Tween(begin: 48, end: 58), weight: 50),
    //     TweenSequenceItem<double>(tween: Tween(begin: 58, end: 48), weight: 50),
    //   ],
    // ).animate(_sizeController);

    _progressController.addListener(() {
      setState(() {});
    });
    // _sizeController.addListener(() {
    //   setState(() {});
    // });
    _progressController.addStatusListener((status) {
      print("_progressController $status");
      if (status == AnimationStatus.dismissed) _sizeController.forward();
    });

    // _sizeController.addStatusListener((status) {
    //   print("_sizeController: $status");
    // });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.habitId;

    return BlocBuilder<HabitsCubit, HabitsState>(builder: (context, state) {
      if (state is HabitsLoaded) {
        DomainHabit habit = getHabit(id);
        return Scaffold(
          appBar: AppBar(
            title: Text(habit.name),
            actions: <Widget>[
              PopupMenuButton<DetailAction>(
                  onSelected: (type) async {
                    if (type == DetailAction.delete)
                      await deleteHabit(context, id);
                    else if (type == DetailAction.update)
                      await updateDays(context, habit);
                  },
                  itemBuilder: (context) => <PopupMenuEntry<DetailAction>>[
                        const PopupMenuItem<DetailAction>(
                            value: DetailAction.delete, child: Text(DELETE)),
                        const PopupMenuItem<DetailAction>(
                            value: DetailAction.update, child: Text(UPDATE)),
                      ])
            ],
          ),
          body: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              habit.imageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: AspectRatio(
                        aspectRatio: 1.27,
                        child: SvgPicture.asset(
                          habit.imageUrl,
                          placeholderBuilder: (context) => Container(),
                        ),
                      ),
                    )
                  : Container(),
              Spacer(flex: 4),
              CustomProgressWidget(
                onTap: () async {
                  _progressController.reverse(from: 1.0);
                  //update database (days)
                  await updateDays(context, habit);
                },
                fillSize: 130,
                completedProgressColor: detailButtonProgressColor,
                emptyProgressColor: Colors.grey.withAlpha(55),
                strokeSize: 15,
                fillColor: detailButtonFillColor,
                textColor: Colors.white,
                textSize: 48,
                topNumber: habit.days,
                progress: (habit.days / 90) * 100,
              ),
              Spacer(flex: 2),
              Text(
                "Status:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                habit.getStatus,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Spacer(flex: 3),
              GestureDetector(
                onTap: () async {
                  //call timePicker
                  await setNotificationTime(habit, context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications),
                      SizedBox(width: 4),
                      Text(
                        habit.notificationTime == NOT_SET
                            ? "Remind with a notification"
                            : displayTime(habit.notificationTime),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      } else
        return Container();
    });
  }
}

enum DetailAction { delete, update }
