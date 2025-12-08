import 'package:flutter/material.dart';
import 'package:swecha_asset_flow/screens/welcome_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwechaAssetFlow',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreenPage(),
      themeMode: ThemeMode.system,
      theme: _lightTheme,
    );
  }

  //LightMode
  final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: const Color.fromARGB(255, 255, 63, 0),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 255, 63, 0),
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
    cardTheme: const CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),
    fontFamily: 'GolosText',
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
      titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      titleSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),

      bodyLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      bodySmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),

      labelLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      labelMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      labelSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
    ),
  );
}
