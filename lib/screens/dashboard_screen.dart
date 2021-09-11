import 'package:flutter/material.dart';
import '../providers/workout_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/workout_program_widget.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "dashboard";

  Future<void> _fetchWorkoutProgram(BuildContext context) {
    return Provider.of<WorkoutProvider>(
      context,
      listen: false,
    ).fetchWorkoutPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      drawer: AppDrawer(),
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
                child: WorkoutProgramWidget(workoutProgram.workoutProgram),
              ),
            );
          }
        },
      ),
    );
  }
}
