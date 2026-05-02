import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'theme.dart';
import 'screens/main_screen.dart';
import 'routes/custom_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
