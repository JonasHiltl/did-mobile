import 'package:flutter/material.dart';

enum AppTheme { dark, light }

const double kSmallPadding = 10;

const double kMediumPadding = 20;

const double kBigPadding = 40;

final appTheme = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF3861FB),
    backgroundColor: const Color(0xFFf7fbff),
    scaffoldBackgroundColor: const Color(0xFFf7fbff),
    errorColor: const Color(0xFFef2b2d),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: Color(0xFFf7fbff),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3861FB),
      secondary: Color(0xFF1890FF),
      primaryVariant: Color(0xFF0B0C10),
      secondaryVariant: Color(0xFF0B0C10),
      onBackground: Color(0xFF0B0C10),
      onSecondary: Color(0xFFFFFFFF),
      background: Color(0xFFf7fbff),
      error: Color(0xFFef2b2d),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        fontSize: 46,
      ),
      headline2: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        fontSize: 38,
      ),
      headline3: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        fontSize: 30,
      ),
      headline4: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      headline5: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      headline6: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      bodyText1: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          const interactiveStates = <MaterialState>{
            MaterialState.focused,
            MaterialState.hovered,
            MaterialState.pressed
          };
          if (states.any(interactiveStates.contains)) {
            return Colors.white;
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(0.25);
          }
          return Colors.white;
        }),
        elevation: MaterialStateProperty.all(0.0),
        padding: MaterialStateProperty.all(
            const EdgeInsets.fromLTRB(20, 12, 20, 12)),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color(0xFF40A9FF);
          }
          if (states.contains(MaterialState.hovered)) {
            return const Color(0xFF40A9FF);
          }
          if (states.contains(MaterialState.pressed)) {
            return const Color(0xFF2C54E9);
          }
          if (states.contains(MaterialState.disabled)) {
            return const Color(0xFFF5F5F5);
          }
          return appTheme[AppTheme.light]!.primaryColor;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color(0xFF40A9FF);
          }
          if (states.contains(MaterialState.hovered)) {
            return const Color(0xFF40A9FF);
          }
          if (states.contains(MaterialState.pressed)) {
            return const Color(0xFF2C54E9);
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(0.03);
          }
          return appTheme[AppTheme.light]!.primaryColor;
        }),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (Set<MaterialState> states) {
            const interactiveStates = <MaterialState>{
              MaterialState.focused,
              MaterialState.hovered,
              MaterialState.pressed
            };
            if (states.any(interactiveStates.contains)) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(
                      color: appTheme[AppTheme.light]!.primaryColor));
            }
            if (states.contains(MaterialState.disabled)) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: const BorderSide(color: Color(0xFFD9D9D9)));
            }
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side:
                    BorderSide(color: appTheme[AppTheme.light]!.primaryColor));
          },
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          const interactiveStates = <MaterialState>{
            MaterialState.focused,
            MaterialState.hovered,
            MaterialState.pressed
          };
          if (states.any(interactiveStates.contains)) {
            return appTheme[AppTheme.light]!.primaryColor;
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(0.25);
          }
          return Colors.black.withOpacity(0.85);
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          const interactiveStates = <MaterialState>{
            MaterialState.focused,
            MaterialState.hovered,
            MaterialState.pressed,
            MaterialState.disabled
          };
          if (states.any(interactiveStates.contains)) {
            return Colors.transparent;
          }
          return appTheme[AppTheme.light]!.primaryColor;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          const interactiveStates = <MaterialState>{
            MaterialState.focused,
            MaterialState.hovered,
            MaterialState.pressed
          };
          if (states.any(interactiveStates.contains)) {
            return BorderSide(color: appTheme[AppTheme.light]!.primaryColor);
          }
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(color: Color(0xFFD9D9D9));
          }
          return const BorderSide(color: Color(0xFFACB6C5));
        }),
        padding: MaterialStateProperty.all(
            const EdgeInsets.fromLTRB(20, 12, 20, 12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        padding: MaterialStateProperty.all(
            const EdgeInsets.fromLTRB(20, 12, 20, 12)),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          const interactiveStates = <MaterialState>{
            MaterialState.focused,
            MaterialState.hovered,
            MaterialState.pressed
          };
          if (states.any(interactiveStates.contains)) {
            return appTheme[AppTheme.light]!.primaryColor;
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(0.25);
          }
          return Colors.black.withOpacity(0.85);
        }),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3861FB),
    backgroundColor: const Color(0xFF2F334D),
  ),
};
