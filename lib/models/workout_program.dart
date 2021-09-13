import 'package:flutter/material.dart';
import '../models/workout_day.dart';
import 'package:intl/intl.dart';

import 'user.dart';

class WorkoutProgram with ChangeNotifier {
  final String? id;
  final DateTime? start;
  final DateTime? end;
  final String? duration;
  final User? user;
  List<WorkoutDay>? workoutDays;

  WorkoutProgram(
      {this.id,
      this.start,
      this.end,
      this.duration,
      this.user,
      this.workoutDays});

  static DateTime? parseDateTime(String? sDate) {
    if (sDate == "" || sDate == "null" || sDate == null)
      return null;
    else
      return DateTime.parse(sDate);
  }

  String get startS {
    return DateFormat("dd-MM-yyyy").format(start!);
  }

  @override
  String toString() {
    return 'WorkoutProgram{id: $id, start: $start, end: $end, duration: $duration, user: $user, workoutDays: $workoutDays}';
  }

  static WorkoutProgram toModel(Map<String, dynamic> data) {
    return WorkoutProgram(
      id: data["id"],
      duration: "${data["duration"]} ${data["durationType"]}",
      start: parseDateTime(data["start"]),
      end: parseDateTime(data["end"]),
      workoutDays: (data["workoutDayList"] as List<dynamic>)
          .map(
            (dataWorkoutDay) => WorkoutDay.fromJson(dataWorkoutDay),
          )
          .toList(),
    );
  }

  static List<WorkoutProgram> toModelList(List<dynamic> data) {
    return data.map((e) => WorkoutProgram.toModel(e)).toList();
  }
}
