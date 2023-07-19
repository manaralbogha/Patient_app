import 'package:flutter/material.dart';

class CustomeErrorWidget extends StatelessWidget {
  final String errorMsg;
  const CustomeErrorWidget({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMsg),
    );
  }
}
