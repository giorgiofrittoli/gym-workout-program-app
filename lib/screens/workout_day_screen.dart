import "package:flutter/material.dart";
import '../models/workout_day.dart';

import '../widgets/workout_day_item.dart';

class WorkoutDayScreen extends StatelessWidget {
  static const routeName = "/workout-day";

  @override
  Widget build(BuildContext context) {
    final workoutDay = ModalRoute.of(context).settings.arguments as WorkoutDay;
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutDay.title),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 5 / 4,
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, i) {
            return WorkoutDayItem(workoutDay.lWorkoutExercise[i]);
          },
          itemCount: workoutDay.lWorkoutExercise.length,
        ),
      ),
    );
  }
}
