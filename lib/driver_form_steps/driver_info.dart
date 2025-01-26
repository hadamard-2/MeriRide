import 'package:flutter/material.dart';
import 'package:meri_ride/my_password_field.dart';
import 'package:meri_ride/phone_num_text_field.dart';

class DriverInfoForm extends StatefulWidget {
  const DriverInfoForm({super.key});

  @override
  State<DriverInfoForm> createState() => _DriverInfoFormState();
}

class _DriverInfoFormState extends State<DriverInfoForm> {
  final phoneNumController = TextEditingController();
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
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
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
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_on_rounded),
            border: OutlineInputBorder(),
          ),
        ),
        const Divider(thickness: 1.5),
        // TextFormField(
        //   obscureText: !passwordVisible,
        //   decoration: InputDecoration(
        //     prefixIcon: const Icon(Icons.lock_rounded),
        //     suffixIcon: InkWell(
        //         onTap: () {
        //           setState(() {
        //             passwordVisible = !passwordVisible;
        //           });
        //         },
        //         child: const Icon(Icons.visibility_rounded)),
        //     labelText: 'Password',
        //     border: const OutlineInputBorder(),
        //   ),
        // ),
        // TextFormField(
        //   obscureText: !passwordVisible,
        //   decoration: InputDecoration(
        //     prefixIcon: const Icon(Icons.lock_rounded),
        //     suffixIcon: InkWell(
        //         onTap: () {
        //           setState(() {
        //             passwordVisible = !passwordVisible;
        //           });
        //         },
        //         child: const Icon(Icons.visibility_rounded)),
        //     labelText: 'Confirm Password',
        //     border: const OutlineInputBorder(),
        //   ),
        // ),
        const MyPasswordField(label: 'Password'),
        const MyPasswordField(label: 'Confirm Password'),
      ],
    );
  }
}
