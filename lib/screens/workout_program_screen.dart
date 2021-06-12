import "package:flutter/material.dart";
import 'package:gym_workout_program/models/workout_program.dart';
import 'package:gym_workout_program/widgets/workout_program_widget.dart';

import "../widgets/app_drawer.dart";

class WorkoutProgramScreen extends StatelessWidget {
  static const routeName = "workout-program";

  final WorkoutProgram id;

  WorkoutProgramScreen(this.id);

  @override
  Widget build(BuildContext context) {
    WorkoutProgram v;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text("Workout program"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: WorkoutProgramWidget(v),
      drawer: AppDrawer(),
    );
  }
}
