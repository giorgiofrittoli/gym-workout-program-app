import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_day.dart';

class WorkoutDayProvider with ChangeNotifier {
  final WorkoutDay workoutDay;

  WorkoutDayProvider(this.workoutDay) {
    workoutDay.lWorkoutExercise[0].active = true;
  }

  void nextExercise() {
    final iExActive =
        workoutDay.lWorkoutExercise.indexWhere((exercise) => exercise.active);
    if (iExActive < workoutDay.lWorkoutExercise.length - 1) {
      workoutDay.lWorkoutExercise[iExActive + 1].active = true;
      workoutDay.lWorkoutExercise[iExActive].active = false;
    }
    notifyListeners();
  }
}
