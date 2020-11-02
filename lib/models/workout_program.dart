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
      {this.id, this.start, this.duration, this.user, this.workoutDays});

  static WorkoutProgram parseWPJson(Map<String, dynamic> data) {
    return WorkoutProgram(
      id: data["id"],
      duration: "${data["duration"]} ${data["durationType"]}",
      start: DateTime.parse(data["start"]),
      workoutDays: (data["workoutDayList"] as List<dynamic>)
          .map(
            (dataWorkoutDay) => WorkoutDay.parseWDJson(dataWorkoutDay),
          )
          .toList(),
    );
  }
}
