import 'package:betcal/ui/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle statusBar({bool isDark = false}) {
  return SystemUiOverlayStyle(
    statusBarColor: isDark ? white : Colors.transparent,
    statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: white,
    systemNavigationBarDividerColor: white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
