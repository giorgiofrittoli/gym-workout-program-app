import 'package:flutter/material.dart';
import 'package:gym_workout_program/helpers/widget_helper.dart';
import 'package:gym_workout_program/models/exercise.dart';
import 'package:gym_workout_program/providers/exercise_provider.dart';
import 'package:provider/provider.dart';

import 'form_dropdown.dart';
import 'input_text.dart';

class WorkoutExerciseForm extends StatefulWidget {
  @override
  State<WorkoutExerciseForm> createState() => _WorkoutExerciseFormState();
}

class _WorkoutExerciseFormState extends State<WorkoutExerciseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _data = {
    "exerciseId": "",
    "reps": "",
    "rest": "",
  };

  void _saveData(String field, String data) {
    _data[field] = data;
  }

  @override
  Widget build(BuildContext context) {
    var exercises = Provider.of<ExcerciseProvider>(
      context,
      listen: false,
    ).exercises;

    exercises = exercises.reversed.toList();
    exercises.add(Exercise(id: "0", name: "", description: ""));

    exercises = exercises.reversed.toList();

    var itemsNegozi = Map<String, String>.fromIterable(
      exercises,
      key: (e) => e.id,
      value: (e) => e.description,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.white),
      ),
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormDropdown(
              field: "exerciseId",
              validator: WidgetHelper.genericDataValidator,
              onChanged: _saveData,
              items: itemsNegozi,
            ),
            SizedBox(
              height: 30,
            ),
            InputText(
              title: "Ripetizioni",
              field: "reps",
              savedInput: _saveData,
              validator: WidgetHelper.genericDataValidator,
              maxLines: 5,
            ),
            SizedBox(
              height: 30,
            ),
            InputText(
              title: "Pausa",
              field: "rest",
              savedInput: _saveData,
              validator: WidgetHelper.genericDataValidator,
            ),
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
