import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviereviewapp/views/secondmain.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const secondmain())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splashscreen.jpg'),
                fit: BoxFit.cover)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 150,
              ),
              Text(
                "MOREVI",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 216, 182, 230)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Movie Review App",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 90, 162)),
              ),
              SizedBox(
                height: 400,
              ),
              Text("Version 1.1b",
                  style: TextStyle(color: Color.fromARGB(255, 117, 241, 241)))
            ]),
      ),
    ));
  }
}
