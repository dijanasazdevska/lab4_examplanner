import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_examplanner/blocs/planner_event.dart';
import 'package:lab4_examplanner/screens/login_screen.dart';
import 'package:lab4_examplanner/services/location_service.dart';
import 'blocs/planner_bloc.dart';
import 'screens/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlannerBloc>(
        create: (BuildContext context) => PlannerBloc(LocationService())..add(PlannerInitializedEvent()),
        child: MaterialApp(
          title: 'Exam Planner',
          theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
          initialRoute: '/login',
          routes: {
            '/home': (ctx) => MainScreen(title: "Exam Planner"),
            '/login': (ctx) => LoginScreen()
          }
    ));
  }
}