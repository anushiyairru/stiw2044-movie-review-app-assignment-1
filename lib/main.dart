import 'package:flutter/material.dart';

import 'views/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
        primarySwatch: Colors.pink,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Color.fromARGB(255, 36, 2, 129),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
