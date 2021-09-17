import "package:flutter/material.dart";
import 'package:gym_workout_program/providers/workout_day_provider.dart';
import "package:provider/provider.dart";

import '../models/workout_exercise.dart';
import "../screens/workout_exercise_screen.dart";

class WorkoutDayItem extends StatefulWidget {
  final int idWorkoutExercise;

  WorkoutDayItem(this.idWorkoutExercise);

  @override
  _WorkoutDayItemState createState() => _WorkoutDayItemState();
}

class _WorkoutDayItemState extends State<WorkoutDayItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutDayProvider>(builder: (_, workoutDayProvider, _c) {
      print(
        "${widget.idWorkoutExercise} - ${workoutDayProvider.workoutDay.lWorkoutExercise[widget.idWorkoutExercise].active}",
      );

      return Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                leading: !_expanded &&
                        !workoutDayProvider.workoutDay
                            .lWorkoutExercise[widget.idWorkoutExercise].active
                    ? WorkoutImage(
                        workoutExercise: workoutDayProvider.workoutDay
                            .lWorkoutExercise[widget.idWorkoutExercise],
                        width: 50,
                        height: 50,
                      )
                    : Text(
                        workoutDayProvider
                            .workoutDay
                            .lWorkoutExercise[widget.idWorkoutExercise]
                            .exercise
                            .name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                title: !_expanded &&
                        !workoutDayProvider.workoutDay
                            .lWorkoutExercise[widget.idWorkoutExercise].active
                    ? Text(workoutDayProvider
                        .workoutDay
                        .lWorkoutExercise[widget.idWorkoutExercise]
                        .exercise
                        .name)
                    : Text(""),
                trailing: workoutDayProvider.workoutDay
                        .lWorkoutExercise[widget.idWorkoutExercise].active
                    ? IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.check),
                        onPressed: () => workoutDayProvider.nextExercise(),
                      )
                    : IconButton(
                        color: Colors.white,
                        icon: Icon(_expanded ||
                                workoutDayProvider
                                    .workoutDay
                                    .lWorkoutExercise[widget.idWorkoutExercise]
                                    .active
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        },
                      ),
              ),
              if (workoutDayProvider.workoutDay
                      .lWorkoutExercise[widget.idWorkoutExercise].active ||
                  _expanded)
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  height: 100,
                  child: Row(
                    children: [
                      WorkoutImage(
                        workoutExercise: workoutDayProvider.workoutDay
                            .lWorkoutExercise[widget.idWorkoutExercise],
                        width: 120,
                        height: 100,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 170,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  workoutDayProvider
                                      .workoutDay
                                      .lWorkoutExercise[
                                          widget.idWorkoutExercise]
                                      .reps,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Pausa: ${workoutDayProvider.workoutDay.lWorkoutExercise[widget.idWorkoutExercise].pause}",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class WorkoutImage extends StatelessWidget {
  const WorkoutImage({
    Key? key,
    required this.workoutExercise,
    required this.width,
    required this.height,
  }) : super(key: key);

  final WorkoutExercise workoutExercise;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
          WorkoutExcerciseScreen.routeName,
          arguments: workoutExercise),
      child: Container(
        width: width,
        height: height,
        child: Image.network(
          workoutExercise.exercise.imageURL!,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
