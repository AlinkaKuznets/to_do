import 'package:flutter/material.dart';
import 'package:to_do/widgets/cases_list_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 106, 196, 237));

void main() {
  runApp(
    MaterialApp(
      home: const CasesListScreen(),
      theme: ThemeData.light().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 106, 196, 237),
          foregroundColor: Colors.white,
        ),
      ),
    ),
  );
}
