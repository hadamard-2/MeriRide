import 'package:flutter/material.dart';
import 'package:meri_ride/driver_form_steps/vehicle_info.dart';
import 'package:meri_ride/driver_form_steps/driver_info.dart';
import 'package:meri_ride/driver_form_steps/documents.dart';
import 'package:meri_ride/home.dart';

class DriverFormNavigator extends StatefulWidget {
  final String? phoneNum;

  const DriverFormNavigator({super.key, this.phoneNum});

  @override
  State<DriverFormNavigator> createState() => _DriverFormNavigatorState();
}

class _DriverFormNavigatorState extends State<DriverFormNavigator> {
  final _driverInfoFormKey = GlobalKey<FormState>();
  final _vehicleInfoFormKey = GlobalKey<FormState>();
  final _documentsFormKey = GlobalKey<FormState>();

  int _index = 0;

  bool _validateCurrentForm() {
    FormState? form;
    if (_index == 0) {
      form = _driverInfoFormKey.currentState;
    } else if (_index == 1) {
      form = _vehicleInfoFormKey.currentState;
    } else if (_index == 2) {
      form = _documentsFormKey.currentState;
    }
    return form?.validate() ?? false;
  }

  void goNext() {
    if (_validateCurrentForm()) {
      setState(() {
        _index++;
      });
    }
  }

  goBack() {
    setState(() {
      _index--;
    });
  }

  goHome() {
    if (_validateCurrentForm()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
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
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stepper(
                type: StepperType.horizontal,
                elevation: 0,
                stepIconBuilder: _stepIconBuilder,
                controlsBuilder: (context, details) => Container(),
                currentStep: _index,
                steps: [
                  Step(
                    title: const Text(
                      'Driver',
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    isActive: _index == 0,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Form(
                        key: _driverInfoFormKey,
                        child: DriverInfoForm(phoneNum: widget.phoneNum),
                      ),
                    ),
                  ),
                  Step(
                    title: const Text(
                      'Vehicle',
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    isActive: _index == 1,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Form(
                        key: _vehicleInfoFormKey,
                        child: const VehicleInfoForm(),
                      ),
                    ),
                  ),
                  Step(
                    title: const Text(
                      'Docs',
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    isActive: _index == 2,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Form(
                        key: _documentsFormKey,
                        child: const Documents(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: _driverFormCustomControls())
        ],
      ),
    );
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
                  icon: const Icon(Icons.arrow_back_rounded),
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
                onPressed: _index < 2 ? goNext : goHome,
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.blue.shade700,
                  backgroundColor: Theme.of(context).colorScheme.primary,
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

  Widget _stepIconBuilder(index, stepState) {
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
        Icons.description_rounded,
        color: Colors.white,
      );
    }
  }
}
