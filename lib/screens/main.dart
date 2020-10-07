import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/cubit/create/create_cubit.dart';
import 'package:habit/cubit/detail/detail_cubit.dart';
import 'package:habit/cubit/home/home_cubit.dart';
import 'package:habit/repository/repository.dart';
import 'package:habit/screens/create_screen.dart';
import 'package:habit/screens/detail_screen.dart';
import 'package:habit/screens/home_screen.dart';
import 'package:habit/utils/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(Repository()),
        ),
        BlocProvider<CreateCubit>(
          create: (context) => CreateCubit(Repository()),
        ),
        BlocProvider<DetailCubit>(
          create: (context) => DetailCubit(Repository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: secondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          CreateScreen.id: (context) => CreateScreen(),
          DetailScreen.id: (context) => DetailScreen(),
        },
      ),
    );
  }
}
