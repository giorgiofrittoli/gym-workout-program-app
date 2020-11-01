import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_day.dart';

import 'user.dart';

class WorkoutProgram with ChangeNotifier {
  final String id;
  final DateTime start;
  final String duration;
  final User user;
  List<WorkoutDay> workoutDays;

  WorkoutProgram(
      {this.id,
      this.start,
      this.duration,
      this.user,
      this.workoutDays});
}
