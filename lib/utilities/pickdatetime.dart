import 'package:flutter/material.dart';

Future<DateTime> pickDateTime(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
  );

  return picked;
}