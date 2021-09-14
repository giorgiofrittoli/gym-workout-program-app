import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_workout_program/providers/exercise_provider.dart';
import 'package:gym_workout_program/widgets/input_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';

class ExerciseScreen extends StatefulWidget {
  static const routeName = "/exercise";

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // esercizio edit
  Exercise? _loadedExercise;

  // immagine selezionata da img picker
  XFile? _pickedImage;

  dynamic _pickImageError;
  String? _retrieveDataError;

  // per selezionare img
  final ImagePicker _picker = ImagePicker();

  var _exerciseData = {
    "name": "",
    "description": "",
    "base64Image": "",
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_pickedImage != null) {
      final bytes = File(_pickedImage!.path).readAsBytesSync();
      _exerciseData["base64Image"] = base64Encode(bytes);
    }

    try {
      if (_loadedExercise != null) {
        Provider.of<ExcerciseProvider>(
          context,
          listen: false,
        ).updateExercise(_loadedExercise!.id, _exerciseData);
      } else {
        Provider.of<ExcerciseProvider>(
          context,
          listen: false,
        ).insertExercise(_exerciseData);
      }

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
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

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        //maxWidth: maxWidth,
        //maxHeight: maxHeight,
        //imageQuality: quality,
      );
      setState(() {
        _pickedImage = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_pickedImage != null) {
      return Container(
        width: 200,
        height: 200,
        child: Image.file(
          File(_pickedImage!.path),
          fit: BoxFit.cover,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else if (_loadedExercise != null &&
        _loadedExercise!.imageURL != null &&
        _loadedExercise!.imageURL!.isNotEmpty) {
      return Container(
        width: 200,
        height: 200,
        child: Image.network(
          _loadedExercise!.imageURL!,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return const Text(
        "Non hai ancora selezionato un'immagine",
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _pickedImage = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadedExercise = ModalRoute.of(context)?.settings.arguments as Exercise?;

    if (_loadedExercise != null) {
      _exerciseData["name"] = _loadedExercise!.name;
      _exerciseData["description"] = _loadedExercise!.description;
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
                  maxLines: 6,
                ),
                SizedBox(height: 30),
                defaultTargetPlatform == TargetPlatform.android
                    ? FutureBuilder<void>(
                        future: retrieveLostData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            case ConnectionState.done:
                              return _previewImages();
                            default:
                              return Text("");
                          }
                        },
                      )
                    : _previewImages(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _onImageButtonPressed(
              ImageSource.gallery,
              context: context,
            ),
            child: const Icon(Icons.photo),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: _submit,
            child: Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
