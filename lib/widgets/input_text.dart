import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String field;
  final String title;
  final String? initValue;
  final Function? validator;
  final Function savedInput;
  final int maxLines;

  InputText({
    required this.field,
    required this.title,
    required this.initValue,
    required this.validator,
    required this.savedInput,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      initialValue: initValue,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusColor: Colors.white,
        focusedErrorBorder: InputFormBorder.build(Colors.red, 2),
        errorBorder: InputFormBorder.build(Colors.red, 2),
        enabledBorder: InputFormBorder.build(Colors.white, 1),
        focusedBorder: InputFormBorder.build(Colors.green, 2),
        labelText: title,
        labelStyle: Theme.of(context).textTheme.subtitle1,
      ),
      style: Theme.of(context).textTheme.subtitle2,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => validator != null ? validator!(field, value) : null,
      onSaved: (value) => savedInput(field, value),
      maxLines: maxLines,
    );
  }
}

class InputFormBorder {
  static OutlineInputBorder build(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );
  }
}
