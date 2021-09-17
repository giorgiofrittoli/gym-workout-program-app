import "dart:convert";
import 'dart:developer';

import 'package:flutter/material.dart';

import '../helpers/server_helper.dart';
import '../models/workout_day.dart';
import '../models/workout_program.dart';

class WorkoutProvider with ChangeNotifier {
  final apiUrl = "${ServerHelper.baseApiUrl}/workoutprogram";

  WorkoutProgram? _workoutProgram;
  List<WorkoutProgram>? _workoutPrograms;
  String? _authToken;
  String? _userId;

  WorkoutProvider(this._workoutProgram, this._authToken, this._userId);

  List<WorkoutProgram> get workoutPrograms {
    return _workoutPrograms != null ? _workoutPrograms! : [];
  }

  WorkoutProgram? get workoutProgram {
    return _workoutProgram;
  }

  List<WorkoutDay> get workoutDays {
    return [..._workoutProgram!.workoutDays!];
  }

  Future<void> fetchWorkoutPrograms() async {
    final response = await ServerHelper.get("$apiUrl/$_userId", _authToken!);

    _workoutPrograms = WorkoutProgram.toModelList(json.decode(response.body));

    log("Wokout programs " + _workoutPrograms.toString());

    _workoutProgram = _workoutPrograms!.firstWhere((wp) => wp.end == null);

    log("Active workout program " + _workoutProgram.toString());

    notifyListeners();
  }
}
