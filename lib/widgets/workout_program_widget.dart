import 'package:flutter/material.dart';
import '../models/workout_program.dart';
import '../widgets/workout_program_item.dart';

class WorkoutProgramWidget extends StatelessWidget {
  final WorkoutProgram? _workoutProgram;

  WorkoutProgramWidget(this._workoutProgram);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          "Data inizio: ${_workoutProgram!.startS}",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 5),
        Text(
          "Durata: ${_workoutProgram!.duration}",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 20),
        Divider(
          thickness: 2,
          color: Colors.white,
        ),
        SizedBox(height: 10),
        Container(
          height: 400,
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return WorkoutProgramItem(_workoutProgram!.workoutDays![i]);
            },
            itemCount: _workoutProgram!.workoutDays!.length,
          ),
        )
      ],
    );
  }
}
