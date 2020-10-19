import "package:flutter/material.dart";
import 'package:gym_workout_program/models/workout_exercise.dart';

class WorkoutExcerciseScreen extends StatelessWidget {
  static const routeName = "/workout-exercize";

  @override
  Widget build(BuildContext context) {
    final workoutExercise =
        ModalRoute.of(context).settings.arguments as WorkoutExercise;
    return Scaffold(
      appBar: AppBar(
        title: Text("${workoutExercise.exercise.title}"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Image.network(
                workoutExercise.exercise.imageURL,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("Descrizione:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  Text(
                    "${workoutExercise.exercise.description}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text("Esecuzione:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  Text(
                    "${workoutExercise.description}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
