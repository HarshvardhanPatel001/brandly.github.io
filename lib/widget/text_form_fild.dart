import 'package:flutter/material.dart';

Widget textFeld({
    String? labelText,
    String? initialValue,
    String? hintText,
    String? Function(String?)? validator,
    IconData? icon,
    required TextInputType inputType,
    required int maxLines,
    int? minLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white70),
        cursorColor: Colors.amber,
        controller: controller,
        validator: validator,
        // initialValue:initialValue ,
        keyboardType: inputType,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.amber.shade600,
            ),
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          labelStyle: TextStyle(
              color: Colors.amber.shade600, fontWeight: FontWeight.bold),
          alignLabelWithHint: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          // border: InputBorder.none,
          fillColor: Colors.transparent,
          filled: true,
        ),
      ),
    );
  }