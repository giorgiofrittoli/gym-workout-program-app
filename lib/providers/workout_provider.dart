import "dart:convert";

import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_day.dart';
import "package:http/http.dart" as http;
import "package:intl/intl.dart";

import '../models/workout_program.dart';

class WorkoutProvider with ChangeNotifier {
  WorkoutProgram _workoutProgram;
  String _authToken = "e4594ccc-aaab-4324-b058-29213ebb4355";

  List<WorkoutDay> get workoutDays {
    return [..._workoutProgram.workoutDays];
  }

  String get durationS {
    return "${_workoutProgram.duration}";
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

    _workoutProgram = WorkoutProgram.parseWPJson(jsonWP);

    notifyListeners();
  }
}
