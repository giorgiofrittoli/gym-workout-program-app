import "package:flutter/material.dart";
import '../providers/workout_provider.dart';
import "package:provider/provider.dart";

import '../widgets/workout_day_item.dart';

class WorkoutDayScreen extends StatelessWidget {
  static const routeName = "/workout-day";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    final wProvider = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    );
    wProvider.resetExercices(id);
    final workoutDay = wProvider.workoutDay(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutDay.title!),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return WorkoutDayItem(id, workoutDay.lWorkoutExercise![i]);
          },
          itemCount: workoutDay.lWorkoutExercise!.length,
        ),
      ),
    );
  }
}
