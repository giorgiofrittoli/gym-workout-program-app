import "package:flutter/material.dart";
import '../models/workout_program.dart';
import '../widgets/workout_program_widget.dart';

import "../widgets/app_drawer.dart";

class WorkoutProgramScreen extends StatelessWidget {
  static const routeName = "workout-program";

  final WorkoutProgram id;

  WorkoutProgramScreen(this.id);

  @override
  Widget build(BuildContext context) {
    WorkoutProgram? v;

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout program"),
      ),
      body: WorkoutProgramWidget(v),
      drawer: AppDrawer(),
    );
  }
}
