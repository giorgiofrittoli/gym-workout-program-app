import 'package:flutter/material.dart';
import 'package:gym_workout_program/helpers/widget_helper.dart';
import 'package:gym_workout_program/widgets/workout_exercise_form.dart';

import 'input_text.dart';

class WorkoutDayForm extends StatefulWidget {
  @override
  State<WorkoutDayForm> createState() => _WorkoutDayFormState();
}

class _WorkoutDayFormState extends State<WorkoutDayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final data = {
    "title": "",
    "exercise": [],
  };

  void _saveData(String field, String value) {
    data[field] = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.white),
      ),
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputText(
              title: "Nome",
              savedInput: _saveData,
              validator: WidgetHelper.genericDataValidator,
              field: "title",
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text("Esercizio")),
              ],
            ),
            SizedBox(height: 10),
            WorkoutExerciseForm(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      size: 35,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
