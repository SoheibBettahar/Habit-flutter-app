import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit/cubit/create/create_cubit.dart';
import 'package:habit/cubit/home/home_cubit.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/screens/create_screen.dart';
import 'package:habit/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> getHabits(BuildContext context) async {
    final homeCubit = context.bloc<HomeCubit>();
    await homeCubit.getHabits();
  }

  @override
  void initState() {
    super.initState();
    getHabits(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(HABIT),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Icon(
                Icons.search,
                size: 24.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.more_vert,
                size: 24.0,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => BlocProvider(
                  create: (BuildContext context) => CreateCubit(),
                  child: CreateScreen()),
            );
          },
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return HabitsList(state.habitsList);
            } else if (state is HomeLoading) {
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
              SvgPicture.asset("images/cat.svg"),
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
  final List<Habit> habits;

  HabitsList(this.habits);

  @override
  Widget build(BuildContext context) {
    print("HabitList count: ${habits.length}");
    return Container(
      child: Center(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final Habit habit = habits[index];
                return ListItem(habit: habit);
              },
            )),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Habit habit;

  ListItem({this.habit});

  @override
  Widget build(BuildContext context) {
    print(habit.toString());
    return ListTile(
      title: Text(habit.name),
      subtitle: Text("Consecutive Days: ${habit.days}/90"),
      trailing: Text("Status: ${habit.status}"),
    );
  }
}
