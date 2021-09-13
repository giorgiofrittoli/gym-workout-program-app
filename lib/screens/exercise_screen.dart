import 'package:flutter/material.dart';
import 'package:gym_workout_program/providers/exercise_provider.dart';
import 'package:gym_workout_program/widgets/input_text.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';

class ExerciseScreen extends StatefulWidget {
  static const routeName = "/exercise";

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _edit = false;

  var _exerciseData = {
    "name": "",
    "description": "",
  };

  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    _isLoading = true;

    try {
      if (_edit) {
        Provider.of<ExcerciseProvider>(
          context,
          listen: false,
        ).updateExercise(_exerciseData);
      } else {
        Provider.of<ExcerciseProvider>(
          context,
          listen: false,
        ).insertExercise(_exerciseData);
      }

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveInput(field, value) {
    _exerciseData[field] = value;
  }

  String? _validateData(String field, String value) {
    if (value.isEmpty) {
      return "Inserire $field";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Exercise? exercise =
        ModalRoute.of(context)?.settings.arguments as Exercise?;

    if (exercise != null) {
      _exerciseData["name"] = exercise.name;
      _exerciseData["description"] = exercise.description;
    }

    final deviceInfo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilo utente"),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        height: deviceInfo.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                InputText(
                  field: "name",
                  title: "Name",
                  validator: _validateData,
                  initValue: _exerciseData["name"],
                  savedInput: _saveInput,
                ),
                SizedBox(height: 30),
                InputText(
                  field: "description",
                  title: "Descrizione",
                  validator: _validateData,
                  initValue: _exerciseData["description"],
                  savedInput: _saveInput,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        child: Icon(Icons.save),
      ),
    );
  }
}
