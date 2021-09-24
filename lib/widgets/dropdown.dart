import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String field;
  final String? title;
  final Function onChanged;
  final String? initValue;
  final Map<String, String>? items;
  final String? disableHint;

  const Dropdown({
    required Key key,
    required this.field,
    this.title,
    required this.onChanged,
    this.items,
    this.initValue = "",
    this.disableHint,
  }) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState(initValue);
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  _DropdownState(String? initValue) {
    if (initValue != null && initValue.isNotEmpty) {
      dropdownValue = initValue;
    }
  }

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) Text(widget!.title!),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
                color: Colors.grey, style: BorderStyle.solid, width: 2),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: DropdownButton<String>(
            disabledHint: Text(
              widget.disableHint == null ? "" : widget!.disableHint!,
            ),
            value: dropdownValue,
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.grey,
            ),
            iconSize: 30,
            underline: DropdownButtonHideUnderline(child: Container()),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
                widget.onChanged(widget.field, newValue);
              });
            },
            items: widget.items?.entries
                .map(
                  (entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(
                      entry.value,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
