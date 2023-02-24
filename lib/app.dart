import 'package:betcal/ui/screens/home.dart';
import 'package:betcal/ui/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.black,
        ),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      title: "Betcal",
      home: const HomeScreen(),
    );
  }
}
