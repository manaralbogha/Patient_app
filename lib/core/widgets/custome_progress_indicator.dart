import 'package:flutter/material.dart';
import 'package:patient_app/core/styles/app_colors.dart';

class CustomeProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomeProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? defaultColor,
      ),
    );
  }
}
