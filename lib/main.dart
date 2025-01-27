import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/credits.dart';
import 'package:meri_ride/user_auth.dart';
// import 'package:meri_ride/credits.dart';
// import 'package:meri_ride/home.dart';
// import 'package:meri_ride/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
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
        iconTheme: const IconThemeData(size: 16),
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     return snapshot.hasData ? const Home() : const UserAuth();
      //   },
      // ),
      home: const CreditsPage(),
    );
  }
}
