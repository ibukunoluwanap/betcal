import 'package:betcal/ui/utils/color.dart';
import 'package:flutter/material.dart';

class Alert {
  const Alert({
    required this.context,
    required this.message,
    this.type,
    this.duration = 4,
    this.onAction,
  });

  final BuildContext context;
  final String message;
  final String? type;
  final int duration;
  final dynamic onAction;

  void show() {
    Color background() {
      if (type == "error") return Colors.red;
      if (type == "success") return Colors.green;
      if (type == "white") return white;
      return primary;
    }

    final snackBar = SnackBar(
      backgroundColor: background(),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: type == "white" ? primary : white,
              ),
            ),
          ),
          const SizedBox(width: 5),
          if (onAction != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                "Here",
                style: TextStyle(
                  color: type == "white" ? primary : white,
                ),
              ),
            ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
