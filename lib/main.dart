import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_constants.dart';
import 'screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppConstants.primaryWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const AssetManagementApp());
}

class AssetManagementApp extends StatelessWidget {
  const AssetManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppConstants.primaryBlack,
        scaffoldBackgroundColor: AppConstants.primaryWhite,
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.light(
          primary: AppConstants.primaryBlack,
          secondary: AppConstants.primaryWhite,
          surface: AppConstants.primaryWhite,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(), // Start with welcome screen
    );
  }
}
