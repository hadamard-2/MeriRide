import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/driver.dart';
import 'package:meri_ride/home.dart';
import 'package:meri_ride/my_password_field.dart';
import 'package:meri_ride/phone_num_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhoneNumLogin extends StatefulWidget {
  final String? phoneNum;
  const PhoneNumLogin({super.key, this.phoneNum});

  @override
  State<PhoneNumLogin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<PhoneNumLogin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumberController;
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(text: widget.phoneNum);
  }

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('https://906c-89-41-26-60.ngrok-free.app/api/login-driver'),
      body: {
        'phone_number': '0${(phoneNumberController.text.replaceAll(' ', ''))}',
        'password': passwordController.text,
      },
    );

    if (!mounted) return; // Guard for context usage
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['driver'];
      final driver = Driver(
        firstName: data['first_name'],
        lastName: data['last_name'],
        phoneNumber: data['phone_number'],
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (builder) => Home(driver: driver),
          ));
    } else {
      final errorMessage = json.decode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
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
                    'MeriRide | Login',
                    style: GoogleFonts.titilliumWeb(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                PhoneNumTextField(phoneNumController: phoneNumberController),
                MyPasswordField(
                    label: 'Password', controller: passwordController),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
