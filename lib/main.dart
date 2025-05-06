import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 43, 13, 113),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        //scaffoldBackgroundColor: const Color.fromARGB(255, 239, 163, 232),
        //appBarTheme: AppBarTheme(
        //backgroundColor: const Color.fromARGB(255, 230, 82, 230),
        //),
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    ),
  );
}
