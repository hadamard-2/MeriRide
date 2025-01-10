import 'package:flutter/material.dart';
import 'package:meri_ride/signup.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
      child: Column(
        spacing: 25,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                radius: 75,
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.grey.shade200,
                  size: 105,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_rounded,
                    size: 30,
                    color: Colors.grey.shade200,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.grey.shade200, width: 2.5),
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
            hint: const Text('City'),
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
          TextFormField(
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_rounded),
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: const Icon(Icons.visibility_rounded)),
              labelText: 'Password',
              border: const OutlineInputBorder(),
            ),
          ),
          TextFormField(
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_rounded),
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: const Icon(Icons.visibility_rounded)),
              labelText: 'Confirm Password',
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
