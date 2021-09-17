import "package:flutter/material.dart";
import 'package:gym_workout_program/models/workout_day.dart';
import 'package:gym_workout_program/providers/workout_day_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/workout_day_item.dart';

class WorkoutDayScreen extends StatelessWidget {
  static const routeName = "/workout-day";

  late WorkoutDay workoutDay;

  @override
  Widget build(BuildContext context) {
    workoutDay = ModalRoute.of(context)!.settings.arguments as WorkoutDay;

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutDay.title),
      ),
      body: Container(
        child: ChangeNotifierProvider(
          create: (ctx) => WorkoutDayProvider(workoutDay),
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return WorkoutDayItem(workoutDay.lWorkoutExercise[i]);
            },
            itemCount: workoutDay.lWorkoutExercise.length,
          ),
        ),
      ),
    );
  }
}
