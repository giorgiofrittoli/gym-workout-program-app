import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/workout_provider.dart";
import '../widgets/workout_program_item.dart';

class WorkoutProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProgram = Provider.of<WorkoutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout program"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Data inizio: ${workoutProgram.startS}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 5),
            Text(
              "Durata: ${workoutProgram.durationS}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Divider(thickness: 2),
            SizedBox(height: 20),
            Container(
              height: 400,
              child: ListView.builder(
                itemBuilder: (ctx, i) {
                  return WorkoutProgramItem(workoutProgram.workoutDays[i]);
                },
                itemCount: workoutProgram.workoutDays.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
