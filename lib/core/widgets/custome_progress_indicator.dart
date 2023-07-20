import 'package:flutter/material.dart';

class CustomeProgressIndicator extends StatelessWidget {
  const CustomeProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
