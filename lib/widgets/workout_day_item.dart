import "package:flutter/material.dart";

import '../models/workout_exercise.dart';
import "../screens/workout_exercise_screen.dart";

class WorkoutDayItem extends StatefulWidget {
  final WorkoutExercise workoutExercise;

  WorkoutDayItem(this.workoutExercise);

  @override
  _WorkoutDayItemState createState() => _WorkoutDayItemState();
}

class _WorkoutDayItemState extends State<WorkoutDayItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(WorkoutExcerciseScreen.routeName, arguments: widget.workoutExercise),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile(
                  leading: !_expanded && !widget.workoutExercise.active
                      ? Container(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            widget.workoutExercise.exercise.imageURL,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(widget.workoutExercise.exercise.title),
                  title: !_expanded && !widget.workoutExercise.active
                      ? Text(widget.workoutExercise.exercise.title)
                      : Text(""),
                  trailing: widget.workoutExercise.active
                      ? IconButton(
                          icon: Icon(Icons.check),
                        )
                      : IconButton(
                          icon: Icon(_expanded || widget.workoutExercise.active
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
              if (widget.workoutExercise.active || _expanded)
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  height: 100,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 100,
                        child: Image.network(
                          widget.workoutExercise.exercise.imageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(widget.workoutExercise.reps),
                                Text(
                                  "Pausa: ${widget.workoutExercise.pause}",
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
