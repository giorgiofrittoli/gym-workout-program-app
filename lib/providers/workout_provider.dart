import "dart:convert";

import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_day.dart';
import 'package:gym_workout_program/models/workout_exercise.dart';
import "package:http/http.dart" as http;
import "package:intl/intl.dart";

import '../models/workout_program.dart';

class WorkoutProvider with ChangeNotifier {
  WorkoutProgram _workoutProgram;
  String _authToken = "32d2bf38-270c-48de-a6d2-4cb454fcb37e";

  List<WorkoutDay> get workoutDays {
    return [..._workoutProgram.workoutDays];
  }

  String get durationS {
    return "${_workoutProgram.duration} ${_workoutProgram.duration}";
  }

  String get startS {
    return DateFormat("dd-MM-yyyy").format(_workoutProgram.start);
  }

  WorkoutDay workoutDay(String id) {
    return _workoutProgram.workoutDays
        .firstWhere((workoutDay) => workoutDay.id == id);
  }

  void resetExercices(String idWorkoutDay) {
    _workoutProgram.workoutDays.forEach((workoutDay) => workoutDay
        .lWorkoutExercise
        .forEach((element) => element.active = false));
    workoutDay(idWorkoutDay).lWorkoutExercise[0].active = true;
  }

  void nextExercise(String id) {
    final WorkoutDay wDay = workoutDay(id);
    final iExActive =
        wDay.lWorkoutExercise.indexWhere((exercise) => exercise.active);
    if (iExActive < wDay.lWorkoutExercise.length - 1) {
      wDay.lWorkoutExercise[iExActive + 1].active = true;
      wDay.lWorkoutExercise[iExActive].active = false;
      notifyListeners();
    }
  }

  Future<void> fetchWorkoutProgram() async {
    final url =
        "http://192.168.1.17:8080/api/v1/workoutprogram/active/$_authToken";
    final response = await http.get(url);
    final jsonWP = json.decode(response.body);

    final workOutDays = (jsonWP["workoutDayList"] as List<dynamic>)
        .map(
          (workoutDay) => WorkoutDay(
              id: workoutDay["id"],
              title: workoutDay["title"],
              description: workoutDay["description"],
              order: int.parse(workoutDay["showOrder"]),
              lWorkoutExercise: (workoutDay["workoutExerciseList"] as List<dynamic>)
                  .map((workoutExercise) => WorkoutExercise(
                      id: workoutExercise["id"],
                      reps: workoutExercise["reps"],
                      pause: workoutExercise["pause"]))
                  .toList()),
        )
        .toList();

    final workoutProgram = WorkoutProgram(
        id: jsonWP["id"],
        duration: "${jsonWP["duration"]} ${jsonWP["durationType"]}",
        start: DateTime.parse(jsonWP["start"]),
        workoutDays: workOutDays);
    _workoutProgram = workoutProgram;
  }
}
