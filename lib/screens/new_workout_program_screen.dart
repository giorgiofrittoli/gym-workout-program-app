import 'package:flutter/material.dart';
import 'package:gym_workout_program/widgets/app_drawer.dart';
import 'package:gym_workout_program/widgets/workout_day_form.dart';

class NewWorkoutProgramScreen extends StatefulWidget {
  static const routeName = "new-workout-program";

  @override
  State<NewWorkoutProgramScreen> createState() =>
      _NewWorkoutProgramScreenState();
}

class _NewWorkoutProgramScreenState extends State<NewWorkoutProgramScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final data = {
    "days": [],
  };

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Nuova scheda"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: mq.size.width * 0.04,
          vertical: mq.size.height * 0.01,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Giorno scheda"),
                SizedBox(height: 10),
                WorkoutDayForm(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(
          Icons.save,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
