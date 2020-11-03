import "dart:convert";

import 'package:flutter/material.dart';
import 'package:gym_workout_program/helpers/server_helper.dart';
import 'package:gym_workout_program/models/workout_day.dart';
import "package:http/http.dart" as http;
import "package:intl/intl.dart";

import '../models/workout_program.dart';

class WorkoutProvider with ChangeNotifier {
  WorkoutProgram _workoutProgram;
  String _authToken =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiJ9.2Bv2LlrmEmq3JWRKIcHFHEMyON-gxHRq0x06wotiB7snGJRHjaFsyo_P35rZC04TC5exQhiMQBWIrMxdFTfh9g";
  String _userId = "e4594ccc-aaab-4324-b058-29213ebb4355";
  final apiUrl = "${ServerHelper.baseApiUrl}/workoutprogram";

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
    final response = await http.get(
      "$apiUrl/active/$_userId",
      headers: {
        "Authorization": _authToken,
      },
    );

    final jsonWP = json.decode(response.body);

    _workoutProgram = WorkoutProgram.parseWPJson(jsonWP);

    notifyListeners();
  }
}
