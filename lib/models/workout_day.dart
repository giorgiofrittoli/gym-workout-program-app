import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_exercise.dart';
import 'package:gym_workout_program/models/workout_program.dart';

import 'workout_program.dart';

class WorkoutDay with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final WorkoutProgram workoutProgram;
  final int order;
  final List<WorkoutExercise> lWorkoutExercise;
  bool active;

  WorkoutDay({
    this.id,
    this.title,
    this.description,
    this.workoutProgram,
    this.order,
    this.lWorkoutExercise,
    this.active = false,
  });
}
