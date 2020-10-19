import 'package:flutter/material.dart';

import './screens/workout_program_screen.dart';
import "./screens/workout_day_screen.dart";
import 'screens/workout_exercise_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: TextStyle(
              fontSize: 16,
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      title: 'Gym workout program',
      home: WorkoutProgramScreen(),
      routes: {
        WorkoutDayScreen.routeName: (_) => WorkoutDayScreen(),
        WorkoutExcerciseScreen.routeName: (_) => WorkoutExcerciseScreen(),
      },
    );
  }
}
