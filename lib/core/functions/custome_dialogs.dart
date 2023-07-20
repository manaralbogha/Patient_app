import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CustomDialogs {
  static showCalenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: 350,
            width: 250,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2000, 1, 1),
              onDateTimeChanged: (value) {
                log('xxxxxx');
                log(value.toString());
              },
            ),
          ),
        );
      },
    );
  }

  static Future<DateTime?> pickDateDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1930, 1, 1),
      lastDate: DateTime.now(),
      // onDatePickerModeChange: (value) {
      //   log('xxxxxxx');
      //   log(value.toString());
      // },
    );
  }
}
