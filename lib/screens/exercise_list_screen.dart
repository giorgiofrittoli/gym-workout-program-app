import 'package:flutter/material.dart';
import 'package:gym_workout_program/screens/exercise_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/widget_helper.dart';
import '../providers/exercise_provider.dart';
import '../widgets/app_drawer.dart';

class ExerciseListScreen extends StatelessWidget {
  static const routeName = "/exercises";

  Future<void> _fetchExercise(BuildContext context) {
    return Provider.of<ExcerciseProvider>(
      context,
      listen: false,
    ).getExcercises();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Esercizi"),
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
              return Consumer<ExcerciseProvider>(
                builder: (ctx, exerciseProvider, _) {
                  return ListView.builder(
                    itemBuilder: (_, i) {
                      return Card(
                        child: ListTile(
                          leading: Text(exerciseProvider.exercises[i].name),
                          onTap: () => Navigator.pushNamed(
                            context,
                            ExerciseScreen.routeName,
                            arguments: exerciseProvider.exercises[i],
                          ),
                        ),
                      );
                    },
                    itemCount: exerciseProvider.exercises.length,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
