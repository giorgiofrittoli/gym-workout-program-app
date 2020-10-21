import "package:flutter/material.dart";

import '../models/workout_exercise.dart';

class WorkoutDayItem extends StatefulWidget {
  final WorkoutExercise workoutExercise;

  WorkoutDayItem(this.workoutExercise);

  @override
  _WorkoutDayItemState createState() => _WorkoutDayItemState();
}

class _WorkoutDayItemState extends State<WorkoutDayItem> {
  var _expanded = false;

  var _activeExercise = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    widget.workoutExercise.exercise.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(widget.workoutExercise.exercise.title),
                trailing: _activeExercise
                    ? IconButton(
                        icon: Icon(Icons.check),
                      )
                    : IconButton(
                        icon: Icon(_expanded || _activeExercise
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        },
                      ),
              ),
            ),
            if (_activeExercise || _expanded) Container(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
