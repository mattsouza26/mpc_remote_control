import 'package:flutter/material.dart';

import 'neumorphic_button_theme.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(255, 255, 255, 1),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          onPrimaryContainer: Color.fromARGB(255, 0, 0, 0),
          secondaryContainer: Color.fromRGBO(28, 28, 29, 1),
          background: Color.fromRGBO(28, 26, 30, 1),
          onBackground: Color.fromRGBO(230, 225, 229, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(10, 10, 10, 1),
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        cardColor: const Color.fromARGB(255, 10, 10, 10),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(28, 28, 29, 1),
          foregroundColor: Color.fromRGBO(230, 225, 229, 1),
        ),
        popupMenuTheme: const PopupMenuThemeData(elevation: 0),
        dialogTheme: const DialogTheme(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
        extensions: <ThemeExtension>[
          NeumorphicButtonTheme.dark(),
        ],
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromRGBO(28, 28, 29, 1),
          actionTextColor: Colors.white,
          contentTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: const MaterialStatePropertyAll(Colors.white),
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green;
            }
            return Colors.grey;
          }),
        ),
      );
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(0, 0, 0, 1),
          onPrimary: Color.fromRGBO(250, 250, 250, 1),
          onPrimaryContainer: Color.fromRGBO(255, 255, 255, 1),
          secondaryContainer: Color.fromRGBO(255, 255, 255, 1),
          background: Color.fromRGBO(250, 250, 250, 1),
          onBackground: Color.fromRGBO(2, 2, 2, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          foregroundColor: Color.fromARGB(255, 59, 59, 59),
        ),
        popupMenuTheme: const PopupMenuThemeData(elevation: 0),
        dialogTheme: const DialogTheme(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
        checkboxTheme: CheckboxThemeData(
          checkColor: const MaterialStatePropertyAll(Colors.white),
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green;
            }
            return Colors.grey;
          }),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          actionTextColor: Colors.black,
          contentTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        extensions: <ThemeExtension>[
          NeumorphicButtonTheme.light(),
        ],
      );
}
