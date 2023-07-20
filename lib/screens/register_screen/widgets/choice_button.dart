import 'package:flutter/material.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/text_styles.dart';

class CustomeChoiceButton extends StatelessWidget {
  final void Function()? maleOnTap;
  final void Function()? femaleOnTap;
  final Color? maleColor;
  final Color? femaleColor;
  final Color? maleTextColor;
  final Color? femaleTextColor;
  const CustomeChoiceButton({
    super.key,
    this.maleOnTap,
    this.femaleOnTap,
    this.maleColor,
    this.femaleColor,
    this.maleTextColor,
    this.femaleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChoiceButtonItem(
            onTap: maleOnTap,
            text: 'Male',
            textColor: maleTextColor,
            backgroundColor: maleColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(26),
              bottomLeft: Radius.circular(26),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          width: .5,
        ),
        Expanded(
          child: ChoiceButtonItem(
            onTap: femaleOnTap,
            text: 'Female',
            backgroundColor: femaleColor,
            textColor: femaleTextColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26),
              bottomRight: Radius.circular(26),
            ),
          ),
        ),
      ],
    );
  }
}

class ChoiceButtonItem extends StatelessWidget {
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final BorderRadiusGeometry? borderRadius;
  const ChoiceButtonItem({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor ?? defaultColor,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyles.textStyle18
                .copyWith(color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
