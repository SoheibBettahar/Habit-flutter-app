import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/cubit/home/home_cubit.dart';
import 'package:habit/database/habit_database.dart';
import 'package:habit/repository/repository.dart';
import 'package:habit/screens/home_screen.dart';
import 'package:habit/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.instance.initDatabase();
  await HabitDatabase.instance.openHabitsBox();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Repository repository = Repository.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          create: (BuildContext context) => HomeCubit(), child: HomeScreen()),
    );
  }

  @override
  void dispose() {
    HabitDatabase.instance.close();
    super.dispose();
  }
}
