import "package:flutter/material.dart";

import '../models/workout_program.dart';
import "../widgets/app_drawer.dart";
import '../widgets/workout_program_widget.dart';

class WorkoutProgramScreen extends StatelessWidget {
  static const routeName = "workout-program";

  @override
  Widget build(BuildContext context) {
    final WorkoutProgram workoutProgram =
        ModalRoute.of(context)!.settings.arguments as WorkoutProgram;

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout program"),
      ),
      body: WorkoutProgramWidget(workoutProgram),
    );
  }
}
