import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Color?> showColorPickerDialog(BuildContext context, Color initialColor) async {
  Color? selectedColor = initialColor;
  return showDialog<Color?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            onColorChanged: (Color color) {
              selectedColor = color;
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('DONE'),
            onPressed: () {
              Navigator.of(context).pop(selectedColor);
            },
          ),
        ],
      );
    },
  );
}

