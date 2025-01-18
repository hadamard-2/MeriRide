import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/phone_num_text_field.dart';
import 'package:meri_ride/driver_form_nav.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _currentImageIndex = 1;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex % 6) + 1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/images/old_cars_$_currentImageIndex.png',
                key: ValueKey<int>(_currentImageIndex),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27),
                  topRight: Radius.circular(27),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const SignupForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var phoneNumController = TextEditingController();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'MeriRide',
                style: GoogleFonts.titilliumWeb(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            PhoneNumTextField(phoneNumController: phoneNumController),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _openDriverFormNavigator,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'ENTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Divider(),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'OR ENTER WITH',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SignInWithButton(icon: 'facebook'),
                SignInWithButton(icon: 'google'),
                SignInWithButton(icon: 'telegram'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _openDriverFormNavigator() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DriverFormNavigator(),
      ),
    );
  }
}

class SignInWithButton extends StatelessWidget {
  final String icon;

  const SignInWithButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(
        'assets/images/$icon.png',
        width: 30,
        color: Colors.grey.shade700,
      ),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.transparent,
        shape: const CircleBorder(side: BorderSide(color: Colors.grey)),
      ),
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digits = newValue.text.replaceAll(' ', ''); // Remove spaces
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 5) buffer.write(' '); // Add spaces at the right spots
      buffer.write(digits[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
