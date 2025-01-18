import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_ride/signup.dart';

class PhoneNumTextField extends StatelessWidget {
  const PhoneNumTextField({
    super.key,
    required this.phoneNumController,
  });

  final TextEditingController phoneNumController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(fontSize: 17),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
        PhoneNumberInputFormatter(),
      ],
      controller: phoneNumController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.phone_rounded),
        prefixText: '+251 ',
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
      ),
    );
  }
}
