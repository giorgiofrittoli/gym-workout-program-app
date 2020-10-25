import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_day.dart';

import 'user.dart';

enum DurationType { DAYS, WEEKS, MONTHS }

class WorkoutProgram with ChangeNotifier {
  final String id;
  final DateTime start;
  final int duration;
  final DurationType durationType;
  final User user;
  List<WorkoutDay> workoutDays;

  get durationString {
    if (this.durationType == DurationType.DAYS) return "giorni";
    if (this.durationType == DurationType.WEEKS) return "settimane";
    if (this.durationType == DurationType.MONTHS) return "mese";
  }

  WorkoutProgram(
      {this.id,
      this.start,
      this.duration,
      this.durationType,
      this.user,
      this.workoutDays});
}
