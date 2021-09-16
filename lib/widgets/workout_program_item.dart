import "package:flutter/material.dart";

import '../models/workout_day.dart';
import '../screens/workout_day_screen.dart';

class WorkoutProgramItem extends StatelessWidget {
  final WorkoutDay workoutDay;

  WorkoutProgramItem(this.workoutDay);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          WorkoutDayScreen.routeName,
          arguments: workoutDay,
        ),
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${workoutDay.title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text("${workoutDay.description}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
