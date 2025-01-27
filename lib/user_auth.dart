import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/phone_num_login.dart';
import 'package:meri_ride/phone_num_text_field.dart';
import 'package:meri_ride/driver_form_nav.dart';
import 'package:meri_ride/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAuth extends StatefulWidget {
  const UserAuth({super.key});

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
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
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const UserAuthForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class UserAuthForm extends StatefulWidget {
  const UserAuthForm({super.key});

  @override
  State<UserAuthForm> createState() => _UserAuthFormState();
}

class _UserAuthFormState extends State<UserAuthForm> {
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
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final snackBarMessenger = ScaffoldMessenger.of(context);

                  if (formKey.currentState?.validate() ?? false) {
                    try {
                      final response = await http.post(
                        Uri.parse(
                            'http://meri-ride-server.test/api/check-driver-exists'),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'phone_number':
                              '0${phoneNumController.text.replaceAll(' ', '')}'
                        }),
                      );

                      if (response.statusCode == 200) {
                        navigator.push(
                          MaterialPageRoute(
                            builder: (_) => PhoneNumLogin(
                                phoneNum: phoneNumController.text),
                          ),
                        );
                      } else if (response.statusCode == 404) {
                        _openDriverFormNavigator(phoneNumController.text);
                      } else {
                        snackBarMessenger.showSnackBar(
                          const SnackBar(
                              content: Text('Unexpected error occurred.')),
                        );
                      }
                    } catch (e) {
                      snackBarMessenger.showSnackBar(
                        const SnackBar(
                            content: Text('Failed to connect to the server.')),
                      );
                    }
                  }
                },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SignInWithButton(icon: 'facebook', onPressed: () {}),
                SignInWithButton(
                  icon: 'google',
                  onPressed: () {
                    AuthService().signInWithGoogle();
                  },
                ),
                SignInWithButton(icon: 'telegram', onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _openDriverFormNavigator(String phoneNum) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverFormNavigator(phoneNum: phoneNum),
      ),
    );
  }
}

class SignInWithButton extends StatelessWidget {
  final String icon;
  final void Function()? onPressed;

  const SignInWithButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
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
