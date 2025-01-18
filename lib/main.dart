import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/signup.dart';
import 'package:meri_ride/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeriRide',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 14.5),
        ),
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: const SignUp(),
      home: const Home(),
    );
  }
}
