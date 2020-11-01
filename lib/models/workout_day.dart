import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_exercise.dart';
import 'package:gym_workout_program/models/workout_program.dart';

import 'workout_program.dart';

class WorkoutDay {
  final String id;
  final String title;
  final String description;
  final int order;
  final List<WorkoutExercise> lWorkoutExercise;
  bool active;

  WorkoutDay({
    this.id,
    this.title,
    this.description,
    this.order,
    this.lWorkoutExercise,
    this.active = false,
  });
}
