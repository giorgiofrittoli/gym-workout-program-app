import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_day.dart';

import 'user.dart';

class WorkoutProgram with ChangeNotifier {
  final String id;
  final DateTime start;
  final DateTime end;
  final String duration;
  final User user;
  List<WorkoutDay> workoutDays;

  WorkoutProgram(
      {this.id,
      this.start,
      this.end,
      this.duration,
      this.user,
      this.workoutDays});

  static DateTime parseDateTime(String sDate) {
    if (sDate == "" || sDate == "null" || sDate == null)
      return null;
    else
      return DateTime.parse(sDate);
  }

  static WorkoutProgram jsonWPToDto(Map<String, dynamic> data) {
    return WorkoutProgram(
      id: data["id"],
      duration: "${data["duration"]} ${data["durationType"]}",
      start: parseDateTime(data["start"]),
      end: parseDateTime(data["end"]),
      workoutDays: (data["workoutDayList"] as List<dynamic>)
          .map(
            (dataWorkoutDay) => WorkoutDay.parseWDJson(dataWorkoutDay),
          )
          .toList(),
    );
  }

  static List<WorkoutProgram> jsonWPListToDto(List<dynamic> data) {
    return data.map((e) => WorkoutProgram.jsonWPToDto(e)).toList();
  }
}
