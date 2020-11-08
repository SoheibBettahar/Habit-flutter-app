import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit/cubit/habits/habits_cubit.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/screens/create_screen.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/styles.dart';
import 'package:habit/utils/utils.dart';
import 'package:habit/widgets/list_item.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  navigateToAboutUs() {
    print("navigateToAboutUs() called");
    // navigate to about us
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(HABIT),
          actions: <Widget>[
            Icon(
              Icons.search,
              size: 24.0,
            ),
            PopupMenuButton<HomeAction>(
                onSelected: (type) async {
                  if (type == HomeAction.aboutUs) navigateToAboutUs();
                  if (type == HomeAction.showNotification){
                    //show dummy notification
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<HomeAction>>[
                      const PopupMenuItem<HomeAction>(
                          value: HomeAction.aboutUs, child: Text(ABOUT_US)),
                      const PopupMenuItem<HomeAction>(
                          value: HomeAction.showNotification,
                          child: Text(SHOW_NOTIFICATION)),
                    ])
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CreateScreen(),
            );
          },
        ),
        body: BlocBuilder<HabitsCubit, HabitsState>(
          builder: (context, state) {
            if (state is HabitsLoaded) {
              return HabitsList(state.habitsList);
            } else if (state is HabitsLoading) {
              return loading();
            } else {
              return EmptyState();
            }
          },
        ));
  }

  Widget loading() {
    return Container(
      child: Center(
        child: Text("State Loading"),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("dev_images/cat.svg"),
              Text(
                NO_HABITS_CREATED,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HabitsList extends StatelessWidget {
  final List<DomainHabit> habits;

  HabitsList(this.habits);

  @override
  Widget build(BuildContext context) {
    print("HabitList count: ${habits.length}");
    return ListView.builder(
      padding: EdgeInsets.only(
          right: listItemPaddingHorizontal,
          left: listItemPaddingHorizontal,
          top: listItemPaddingVertical),
      clipBehavior: Clip.hardEdge,
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final DomainHabit habit = habits[index];
        return ListItem(
          habit: habit,
          index: index,
        );
      },
    );
  }
}

enum HomeAction { aboutUs, showNotification }
