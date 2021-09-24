import 'package:flutter/material.dart';

class FormDropdown extends StatefulWidget {
  final String field;
  final String? title;
  final Function onChanged;
  final String initValue;
  final Map<String, String> items;
  final Function? validator;

  const FormDropdown({
    Key? key,
    required this.field,
    this.title,
    required this.onChanged,
    required this.items,
    this.initValue = "",
    required this.validator,
  }) : super(key: key);

  @override
  _FormDropdownState createState() => _FormDropdownState(initValue);
}

class _FormDropdownState extends State<FormDropdown> {
  _FormDropdownState(String initValue) {
    if (initValue.isNotEmpty) {
      dropdownValue = initValue;
    }
  }

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) Text(widget.title!),
        SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            focusColor: Colors.green,
            focusedErrorBorder: InputFormBorder.build(Colors.red, 2),
            errorBorder: InputFormBorder.build(Colors.red, 2),
            enabledBorder: InputFormBorder.build(Colors.white, 1),
            focusedBorder: InputFormBorder.build(Colors.green, 2),
            disabledBorder: InputFormBorder.build(Colors.grey, 2),
            errorStyle: TextStyle(
              color: Colors.red, // or any other color
            ),
          ),
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down_outlined,
            color: Colors.white,
          ),
          iconSize: 30,
          style: const TextStyle(color: Colors.white),
          validator: (value) => widget.validator != null
              ? widget.validator!(widget.title, value)
              : null,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue;
              widget.onChanged(widget.field, newValue);
            });
          },
          items: widget.items.entries
              .map((entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  ))
              .toList(),
        ),
      ],
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
