import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/workout_provider.dart";
import "../widgets/app_drawer.dart";
import '../widgets/workout_program_item.dart';

class WorkoutProgramScreen extends StatelessWidget {

  static const routeName = "workout-program";

  Future<void> _fetchWorkoutProgram(BuildContext context) {
    return Provider.of<WorkoutProvider>(
      context,
      listen: false,
    ).fetchWorkoutProgram();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text("Workout program"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: FutureBuilder(
        future: _fetchWorkoutProgram(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<WorkoutProvider>(
              builder: (ctx, workoutProgram, child) => Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Data inizio: ${workoutProgram.startS}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Durata: ${workoutProgram.durationS}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 2,color: Colors.white,),
                    SizedBox(height: 10),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          return WorkoutProgramItem(
                              workoutProgram.workoutDays[i]);
                        },
                        itemCount: workoutProgram.workoutDays.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
