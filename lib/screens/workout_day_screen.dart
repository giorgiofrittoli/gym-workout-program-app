import "package:flutter/material.dart";
import 'package:gym_workout_program/models/workout_day.dart';
import "package:provider/provider.dart";

import '../providers/workout_provider.dart';
import '../widgets/workout_day_item.dart';

class WorkoutDayScreen extends StatelessWidget {
  static const routeName = "/workout-day";

  @override
  Widget build(BuildContext context) {
    final workoutDay = ModalRoute.of(context)!.settings.arguments as WorkoutDay;

    final wProvider = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    );

    wProvider.resetExercices(workoutDay.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutDay.title!),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return WorkoutDayItem(
              workoutDay.id,
              workoutDay.lWorkoutExercise![i],
            );
          },
          itemCount: workoutDay.lWorkoutExercise!.length,
        ),
      ),
    );
  }
}
