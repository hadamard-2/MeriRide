import 'package:flutter/material.dart';
import 'package:meri_ride/my_password_field.dart';
import 'package:meri_ride/phone_num_text_field.dart';

class DriverInfoForm extends StatefulWidget {
  final String? phoneNum;
  const DriverInfoForm({super.key, this.phoneNum});

  @override
  State<DriverInfoForm> createState() => _DriverInfoFormState();
}

class _DriverInfoFormState extends State<DriverInfoForm> {
  late TextEditingController phoneNumController;
  List<String> cities = [
    'Addis Ababa',
    'Semera',
    'Bahir Dar',
    'Asosa',
    'Hosaina',
    'Dire Dawa',
    'Gambela',
    'Harar',
    'Hawassa',
    'Jijiga',
    'Wolaita Sodo',
    'Bonga',
    'Mek\'ele'
  ];
  late String currentValue;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    phoneNumController = TextEditingController(text: widget.phoneNum);
    currentValue = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              radius: 60,
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 90,
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_rounded,
                  size: 22,
                  color: Colors.white,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 2.5),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'First name is required';
                  } else if (value.trim().length < 3) {
                    return 'First name must be at least 3 characters long';
                  } else if (value.trim().length > 50) {
                    return 'First name cannot be longer than 50 characters';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Last name is required';
                  } else if (value.trim().length < 3) {
                    return 'Last name must be at least 3 characters long';
                  } else if (value.trim().length > 50) {
                    return 'Last name cannot be longer than 50 characters';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        PhoneNumTextField(phoneNumController: phoneNumController),
        DropdownButtonFormField(
          hint: const Text('City', style: TextStyle(fontSize: 14.5)),
          items: cities.map((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              currentValue = newValue.toString();
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'City is required';
            }
            return null;
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_on_rounded),
            border: OutlineInputBorder(),
          ),
        ),
        const Divider(thickness: 1.5),
        const MyPasswordField(label: 'Password'),
        const MyPasswordField(label: 'Confirm Password'),
      ],
    );
  }
}
