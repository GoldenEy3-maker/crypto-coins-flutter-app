import "package:flutter/material.dart";

class AppTheme {
  final Color darkBackgroundColor = const Color(0xff131313);
  final Color lightBackgroundColor = const Color(0xffffffff);
  final Color darkTextColor = const Color(0xffffffff);
  final Color lightTextColor = const Color(0xff000000);

  ThemeData get darkTheme => ThemeData(
    dividerColor: darkTextColor.withValues(alpha: .4),
    scaffoldBackgroundColor: darkBackgroundColor,
    canvasColor: darkTextColor,
    cardTheme: CardThemeData(
      color: Colors.grey.shade900,
      surfaceTintColor: Colors.amber.shade900,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkBackgroundColor,
    ),
    iconTheme: IconThemeData(color: darkTextColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackgroundColor,
      selectedItemColor: Colors.amber,
      unselectedItemColor: darkTextColor.withValues(alpha: 0.4),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.amber,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackgroundColor,
      actionsIconTheme: IconThemeData(color: darkTextColor),
      iconTheme: IconThemeData(color: darkTextColor),
      elevation: 0,
      surfaceTintColor: darkBackgroundColor,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: .w600,
        color: darkTextColor,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: .w600,
        color: darkTextColor,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: darkTextColor.withValues(alpha: .5),
      ),
    ),
    colorScheme: ColorScheme.dark(
      surface: darkBackgroundColor,
      onSurface: darkTextColor,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: darkTextColor,
      displayColor: darkTextColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: darkTextColor),
      ),
      activeIndicatorBorder: BorderSide(color: Colors.amber.shade900),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amber.shade900),
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return const TextStyle(color: Colors.red);
        }

        if (states.contains(WidgetState.focused)) {
          return TextStyle(color: Colors.amber.shade900);
        }

        return TextStyle(color: darkTextColor);
      }),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.amber.shade900,
    ),
  );

  ThemeData get lightTheme => ThemeData(
    dividerColor: lightTextColor.withValues(alpha: .2),
    scaffoldBackgroundColor: lightBackgroundColor,
    canvasColor: lightTextColor,
    iconTheme: IconThemeData(color: lightTextColor),
    cardTheme: CardThemeData(
      color: Colors.grey.shade200,
      surfaceTintColor: Colors.amber.shade800,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightBackgroundColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightBackgroundColor,
      selectedItemColor: Colors.amber,
      unselectedItemColor: lightTextColor.withValues(alpha: 0.4),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.amber,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackgroundColor,
      actionsIconTheme: IconThemeData(color: lightTextColor),
      iconTheme: IconThemeData(color: lightTextColor),
      elevation: 0,
      surfaceTintColor: lightBackgroundColor,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: .w600,
        color: lightTextColor,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: .w600,
        color: lightTextColor,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: lightTextColor.withValues(alpha: .5),
      ),
    ),
    colorScheme: ColorScheme.light(
      surface: lightBackgroundColor,
      onSurface: lightTextColor,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: lightTextColor,
      displayColor: lightTextColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: lightTextColor),
      ),
      activeIndicatorBorder: BorderSide(color: lightTextColor),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amber.shade900),
      ),
      floatingLabelStyle: TextStyle(color: Colors.amber.shade900),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.amber.shade900,
    ),
  );
}
