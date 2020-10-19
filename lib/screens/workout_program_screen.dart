import "package:flutter/material.dart";

import "../dummy_data.dart";
import '../widgets/workout_program_item.dart';

class WorkoutProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              "Data inizio: ${workoutProgram.start}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 5),
            Text(
              "Durata: ${workoutProgram.duration} ${workoutProgram.durationString}",
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
