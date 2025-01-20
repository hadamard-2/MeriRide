import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<User> signInWithGoogle() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      // If the user is already signed in, return the user
      if (currentUser != null) {
        debugPrint("User already signed in: ${currentUser.email}");
        return currentUser;
      }

      // Trigger Google Sign-In
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // Set custom scopes if needed
      googleProvider
        ..addScope('email')
        ..addScope('profile');

      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithPopup(googleProvider);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a Passenger object
        // Check if the user exists in Firestore
        // final existingPassenger =
        //     await Firebaseutillies().getPassengerFromFirestore(user.uid);

        // if (existingPassenger != null) {
        //   // User already exists, redirect to home
        //   print("User already exists in Firestore. Redirecting to home.");
        //   return user;
        // } else {
        //   final passenger = Passenger(
        //     id: user.uid,
        //     phone_number:
        //         user.phoneNumber ?? 'Unknown', // Default if no phone number
        //     first_name: user.displayName?.split(' ').first ??
        //         'Unknown', // Extract first name
        //     last_name: 'Unknown', // Extract last name
        //     profile_photo: user.photoURL ??
        //         "https://lh3.googleusercontent.com/a/AEdFTp4wIcFvcdLSRoBqJsF4Y-lzb_hHL8k7jqnCYBs0=s96-c", // Default profile photo
        //     created_at: user.metadata.creationTime?.toIso8601String() ??
        //         'Unknown', // Creation time
        //     email: user.email ?? 'Unknown', // Default email if null
        //     payment_method: 'cash'
        //   );
        //   await Firebaseutillies().savePassengerToFirestore(passenger);

        //   print("User signed up: ${user.email},");
        // }
      }
      return user!;
    } catch (e) {
      debugPrint("Error signing in with Google: $e");
      throw Exception("Error signing in with Google");
    }
  }
}
