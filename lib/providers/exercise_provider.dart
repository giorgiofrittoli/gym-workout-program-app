import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../helpers/server_helper.dart';
import '../models/exercise.dart';

class ExcerciseProvider with ChangeNotifier {
  final apiUrl = "${ServerHelper.baseApiUrl}/exercise";

  String? _authToken;
  List<Exercise>? _exercises;

  ExcerciseProvider(this._exercises, this._authToken);

  List<Exercise> get exercises {
    return _exercises != null ? [..._exercises!] : [];
  }

  Future<void> getExcercises() async {
    log("getExcercises");
    final response = await ServerHelper.get("$apiUrl/list", _authToken!);
    _exercises = Exercise.fromJsonList(json.decode(response.body));
    notifyListeners();
  }

  Future<void> insertExercise(Map<String, String> data) async {
    await getExcercises();
  }

  Future<void> updateExercise(Map<String, String> data) async {
    // log("updateAppuntamento");
    //
    // appuntamento.idUser = idUser;
    //
    // final response = await ServerHelper.put(
    //   "$apiUrl?action=UPDATE&id=${appuntamento.id}",
    //   json.encode(appuntamento.toPostMap()),
    //   _authToken,
    // );
    //
    // log(response.body);

    await getExcercises();
  }
}
