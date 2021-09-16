import 'package:flutter/material.dart';
import 'package:gym_workout_program/providers/workout_provider.dart';
import 'package:gym_workout_program/screens/exercise_screen.dart';
import 'package:gym_workout_program/screens/workout_program_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/widget_helper.dart';
import '../widgets/app_drawer.dart';

class WorkoutProgramsScreen extends StatelessWidget {
  static const routeName = "/workout-programs";

  Future<void> _fetchExercise(BuildContext context) {
    return Provider.of<WorkoutProvider>(
      context,
      listen: false,
    ).fetchWorkoutPrograms();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Schede"),
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: mq.size.width * 0.04,
          vertical: mq.size.height * 0.01,
        ),
        height: WidgetHelper.calcHeight(1, mq, hasNavbar: false),
        child: FutureBuilder(
          future: _fetchExercise(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<WorkoutProvider>(
                builder: (ctx, workoutProvider, _) {
                  return ListView.builder(
                    itemBuilder: (_, i) {
                      return Card(
                        child: ListTile(
                          leading: Text(
                            "Scheda del ${workoutProvider.workoutPrograms[i].startS}",
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            WorkoutProgramScreen.routeName,
                            arguments: workoutProvider.workoutPrograms[i],
                          ),
                        ),
                      );
                    },
                    itemCount: workoutProvider.workoutPrograms.length,
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(
          ExerciseScreen.routeName,
        ),
      ),
    );
  }
}
