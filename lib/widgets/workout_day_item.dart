import "package:flutter/material.dart";
import '../models/workout_exercise.dart';

import '../screens/workout_exercise_screen.dart';

class WorkoutDayItem extends StatelessWidget {
  final WorkoutExercise workoutExercise;

  WorkoutDayItem(this.workoutExercise);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                WorkoutExcerciseScreen.routeName,
                arguments: workoutExercise,
              );
            },
            child: Image.network(
              workoutExercise.exercise.imageURL,
              fit: BoxFit.fill,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text("${workoutExercise.exercise.title}"),
          ),
        ),
      ),
    );
  }
}
