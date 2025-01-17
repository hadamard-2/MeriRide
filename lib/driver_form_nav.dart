import 'package:flutter/material.dart';
import 'driver_form_steps/vehicle_info.dart';
import 'driver_form_steps/driver_info.dart';
import 'driver_form_steps/documents.dart';

class DriverFormNavigator extends StatefulWidget {
  const DriverFormNavigator({super.key});

  @override
  State<DriverFormNavigator> createState() => _DriverFormNavigatorState();
}

class _DriverFormNavigatorState extends State<DriverFormNavigator> {
  final _formKey = GlobalKey<FormState>();
  int _index = 0;

  goNext() {
    setState(() {
      _index++;
    });
  }

  goBack() {
    setState(() {
      _index--;
    });
  }

  Widget _driverFormCustomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        spacing: 10,
        children: [
          if (_index > 0)
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 45,
                child: IconButton(
                  onPressed: _index > 0 ? goBack : null,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                  iconSize: 25,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 10,
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: _index < 2 ? goNext : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  _index < 2 ? 'NEXT' : 'FINISH',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Driver Registration',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Stepper(
                type: StepperType.horizontal,
                elevation: 0,
                stepIconBuilder: (index, stepState) {
                  if (index == 0) {
                    return const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                    );
                  } else if (index == 1) {
                    return const Icon(
                      Icons.directions_car_rounded,
                      color: Colors.white,
                    );
                  } else {
                    return const Icon(
                      Icons.file_present_rounded,
                      color: Colors.white,
                    );
                  }
                },
                controlsBuilder: (context, details) => Container(),
                currentStep: _index,
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: [
                  Step(
                    title: const Text(
                      '',
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    isActive: _index == 0,
                    content: const Padding(
                      padding: EdgeInsets.only(left: 36, right: 36, bottom: 20),
                      child: DriverInfoForm(),
                    ),
                  ),
                  Step(
                      title: const Text(
                        '',
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      isActive: _index == 1,
                      content: const Padding(
                        padding:
                            EdgeInsets.only(left: 36, right: 36, bottom: 20),
                        child: VehicleInfoForm(),
                      )),
                  Step(
                      title: const Text(
                        '',
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      isActive: _index == 2,
                      content: const Padding(
                        padding:
                            EdgeInsets.only(left: 36, right: 36, bottom: 20),
                        child: Documents(),
                      )),
                ],
              ),
            ),
            Expanded(flex: 1, child: _driverFormCustomControls())
          ],
        ),
      ),
    );
  }
}
