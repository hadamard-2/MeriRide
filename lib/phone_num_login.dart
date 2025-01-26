import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/my_password_field.dart';
import 'package:meri_ride/phone_num_text_field.dart';

class PhoneNumLogin extends StatelessWidget {
  final String? phoneNum;
  const PhoneNumLogin({super.key, this.phoneNum});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var phoneNumController = TextEditingController(text: phoneNum);

    return Scaffold(
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
                  'MeriRide',
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PhoneNumTextField(phoneNumController: phoneNumController),
              const MyPasswordField(label: 'Password'),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // send login credentials to the backend and wait for approval
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
    );
  }
}
