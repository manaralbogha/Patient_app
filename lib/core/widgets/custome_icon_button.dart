import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CustomeIconButton extends StatelessWidget {
  final IconData icon;
  final double? size;
  final void Function()? onPressed;
  const CustomeIconButton({
    super.key,
    required this.icon,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 45,
      height: size ?? 45,
      decoration: const BoxDecoration(
          color: Color(0xFFEDDBD8),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Icon(
          icon,
          size: size == null ? 30.0 : (size! * (2 / 3)),
          color: defaultColor,
        ),
      ),
    );
  }
}
