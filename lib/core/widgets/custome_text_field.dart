import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import 'custome_icon.dart';

class CustomeTextField extends StatelessWidget {
  final String? hintText;
  final IconData? iconData;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool disableFocusNode;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextCapitalization? textCapitalization;
  const CustomeTextField({
    super.key,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.disableFocusNode = false,
    this.initialValue,
    this.hintStyle,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomeIcon(
          icon: iconData ?? Icons.email,
          size: 50,
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 270.w,
          child: TextFormField(
            validator: validator ??
                (value) {
                  if (value?.isEmpty ?? true) {
                    return 'required ...';
                  }
                  return null;
                },
            onTap: onTap,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            initialValue: initialValue,
            focusNode: disableFocusNode ? AlwaysDisabledFocusNode() : null,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            onChanged: onChanged,
            cursorColor: defaultColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(fontSize: 20, color: defaultColor.withOpacity(.6)),
              suffixIcon: suffixIcon,
              focusedBorder: getBorder(),
            ),
          ),
        ),
      ],
    );
  }

  UnderlineInputBorder getBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: defaultColor,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
