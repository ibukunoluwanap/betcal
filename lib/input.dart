import 'package:flutter/material.dart';

class Input {
  const Input({
    this.labelText,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.color = Colors.pink,
    this.isFloatingLabel = true,
    this.isFixedLabel = false,
  });

  final String? labelText;
  final String? hintText;
  final Widget? suffix;
  final IconData? suffixIcon;
  final dynamic suffixIconOnTap;
  final Color color;
  final bool isFloatingLabel;
  final bool isFixedLabel;

  decoration() {
    floatingLabelBehavior() {
      if (isFloatingLabel && !isFixedLabel) {
        return FloatingLabelBehavior.auto;
      } else if (!isFloatingLabel && isFixedLabel) {
        return FloatingLabelBehavior.always;
      } else {
        return FloatingLabelBehavior.never;
      }
    }

    return InputDecoration(
      prefixIconColor: color,
      suffixIcon: GestureDetector(
        onTap: suffixIconOnTap,
        child: suffix ??
            Icon(
              suffixIcon,
              size: 18,
              color: color,
            ),
      ),
      filled: true,
      fillColor: color.withOpacity(.05),
      focusColor: color,
      hoverColor: color,
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(color: color.withOpacity(.5), fontSize: 16),
      hintStyle: TextStyle(color: color.withOpacity(.5), fontSize: 16),
      floatingLabelBehavior: floatingLabelBehavior(),
      counterStyle: const TextStyle(height: double.minPositive),
      counterText: "",
      contentPadding: const EdgeInsets.fromLTRB(18, 18, 0, 18),
      // border design
      border: OutlineInputBorder(
        borderSide: BorderSide(color: color.withOpacity(.5)),
        borderRadius: BorderRadius.circular(5),
      ),
      // enabled border design
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.withOpacity(.5)),
        borderRadius: BorderRadius.circular(5),
      ),
      // focused border design
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color.withOpacity(.5)),
        borderRadius: BorderRadius.circular(5),
      ),
      // error border design
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(.5)),
        borderRadius: BorderRadius.circular(5),
      ),
      // focused error border design
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(.5)),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
