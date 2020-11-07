import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/cubit/habits/habits_cubit.dart';
import 'package:habit/database/habit_database.dart';
import 'package:habit/repository/repository.dart';
import 'package:habit/screens/home_screen.dart';
import 'package:habit/screens/onboarding_screen.dart';
import 'package:habit/utils/notification_helper.dart';
import 'package:habit/utils/styles.dart';
import 'package:habit/utils/utils.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initDatabase();
  await HabitDatabase.openHabitsBox();
  //update all notes according to (using creationTime and DateTime.now()
  //use FlutterNotificationHelper.scheduleNotification.
  //don't use workManager
  bool isFirstTime = await getFirstTIme();
  await Workmanager.initialize(callbackDispatcher);
  await NotificationHelper.initNotifications();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => BlocProvider(
      create: (context) => HabitsCubit(Repository.instance)..getAll(),
      child: MyApp(
        isFirstTime: isFirstTime,
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;

  MyApp({@required this.isFirstTime});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
      builder: DevicePreview.appBuilder,
      // home: widget.isFirstTime ? OnBoardingScreen() : HomeScreen(),
      home: widget.isFirstTime ? OnBoardingScreen() : HomeScreen(),
    );
  }

  @override
  void dispose() {
    HabitDatabase.close();
    super.dispose();
  }
}
