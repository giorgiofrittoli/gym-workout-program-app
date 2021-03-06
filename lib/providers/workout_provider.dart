import "dart:convert";
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gym_workout_program/helpers/server_helper.dart';
import 'package:gym_workout_program/models/workout_day.dart';
import "package:intl/intl.dart";

import '../models/workout_program.dart';

class WorkoutProvider with ChangeNotifier {
  final apiUrl = "${ServerHelper.baseApiUrl}/workoutprogram";

  WorkoutProgram _workoutProgram;
  List<WorkoutProgram> _oldWorkoutPrograms;
  String _authToken;
  String _userId;

  WorkoutProvider(this._workoutProgram, this._authToken, this._userId);

  WorkoutProgram get workoutProgram {
    return _workoutProgram;
  }

  List<WorkoutDay> get workoutDays {
    return [..._workoutProgram.workoutDays];
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

  Future<void> fetchWorkoutPrograms() async {
    final response = await ServerHelper.get("$apiUrl/$_userId", _authToken);

    var _workoutPrograms =
        WorkoutProgram.toModelList(json.decode(response.body));

    log("Wokout programs " + _workoutPrograms.toString());

    _workoutProgram = _workoutPrograms.firstWhere((wp) => wp.end == null);

    log("Active workout program " + _workoutProgram.toString());

    _oldWorkoutPrograms =
        _workoutPrograms.where((wp) => wp.end == null).toList();

    log("Old workout programs " + _oldWorkoutPrograms.toString());

    notifyListeners();
  }
}
