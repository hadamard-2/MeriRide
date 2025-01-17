import 'package:flutter/material.dart';
import 'driver_form_steps/vehicle_info.dart';
import 'driver_form_steps/driver_info.dart';
// import 'driver_form_steps/documents.dart';

class DriverFormNavigator extends StatefulWidget {
  const DriverFormNavigator({super.key});

  @override
  State<DriverFormNavigator> createState() => _DriverFormNavigatorState();
}

class _DriverFormNavigatorState extends State<DriverFormNavigator> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'Driver Registration',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  ProgressIndicator(title: 'Driver Info'),
                  ProgressIndicator(title: 'Vehicle Info', active: true),
                  ProgressIndicator(title: 'Documents'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
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
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Form(
                      key: _formKey,
                      child:
                          const SingleChildScrollView(child: VehicleInfoForm()),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  final String title;
  final bool active;

  const ProgressIndicator(
      {super.key, required this.title, this.active = false});

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: widget.active ? FontWeight.bold : FontWeight.normal,
                color: widget.active ? Colors.blue : Colors.grey,
                fontSize: 17,
              ),
            ),
            Container(
              height: 4.5,
              decoration: BoxDecoration(
                color: widget.active ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(2.25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
