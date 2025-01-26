import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneNumTextField extends StatelessWidget {
  const PhoneNumTextField({
    super.key,
    required this.phoneNumController,
  });

  final TextEditingController phoneNumController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNumController,
      readOnly: phoneNumController.text.isNotEmpty,
      style: GoogleFonts.inter(fontSize: 17),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
        PhoneNumberInputFormatter(),
      ],
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.phone_rounded),
        prefixText: '+251 ',
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        value = value?.replaceAll(' ', '');
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (value.length != 9) {
          return 'Phone number must be 9 digits';
        }
        return null;
      },
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
