import 'package:flutter/material.dart';
import 'package:scheduler/Status/status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor:Color(0xFFECECEC)  ),
      home: const StatusPage(), // Initial screen
    );
  }
}
