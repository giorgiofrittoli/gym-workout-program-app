import "package:flutter/material.dart";
import '../providers/workout_provider.dart';
import "package:provider/provider.dart";

import '../models/workout_exercise.dart';
import "../screens/workout_exercise_screen.dart";

class WorkoutDayItem extends StatefulWidget {
  final String? idWorkoutDay;
  final WorkoutExercise workoutExercise;

  WorkoutDayItem(this.idWorkoutDay, this.workoutExercise);

  @override
  _WorkoutDayItemState createState() => _WorkoutDayItemState();
}

class _WorkoutDayItemState extends State<WorkoutDayItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (_, workoutProvider, _c) => Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Card(
          color: Theme.of(context).accentColor,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                leading: !_expanded && !widget.workoutExercise.active
                    ? WorkoutImage(
                        workoutExercise: widget.workoutExercise,
                        width: 50,
                        height: 50,
                      )
                    : Text(
                        widget.workoutExercise.exercise!.name!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                title: !_expanded && !widget.workoutExercise.active
                    ? Text(widget.workoutExercise.exercise!.name!)
                    : Text(""),
                trailing: widget.workoutExercise.active
                    ? IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.check),
                        onPressed: () => Provider.of<WorkoutProvider>(
                          context,
                          listen: false,
                        ).nextExercise(widget.idWorkoutDay),
                      )
                    : IconButton(
                        color: Colors.white,
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
              if (widget.workoutExercise.active || _expanded)
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  height: 100,
                  child: Row(
                    children: [
                      WorkoutImage(
                        workoutExercise: widget.workoutExercise,
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
                                  widget.workoutExercise.reps!,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Pausa: ${widget.workoutExercise.pause}",
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
      ),
    );
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
          workoutExercise.exercise!.imageURL!,
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
