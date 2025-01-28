import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meri_ride/driver.dart';
import 'package:meri_ride/driver_form_steps/driver_info.dart';
import 'package:meri_ride/driver_form_steps/vehicle_info.dart';
import 'package:meri_ride/driver_form_steps/documents.dart';
import 'package:meri_ride/home.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';

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

  // Driver Info Controllers
  PlatformFile? profilePhotoFile;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String selectedCity = 'Addis Ababa';
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Vehicle Info Controllers
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController licenseNoController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();
  String selectedCountry = 'Ethiopia';
  DateTime licenseIssueDate = DateTime.now();
  DateTime licenseExpiryDate = DateTime.now();

  // Documents Controllers & Files
  final TextEditingController tinController = TextEditingController();
  PlatformFile? vehicleOwnershipFile;
  PlatformFile? libreFile;
  PlatformFile? insuranceFile;
  PlatformFile? businessRegistrationFile;
  PlatformFile? businessLicenseFile;

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

  void goHome() async {
    debugPrint('Starting goHome()...');

    debugPrint('Profile photo file: ${profilePhotoFile != null}');
    debugPrint('Vehicle ownership file: ${vehicleOwnershipFile != null}');
    debugPrint('Libre file: ${libreFile != null}');
    debugPrint('Insurance file: ${insuranceFile != null}');
    debugPrint(
        'Business registration file: ${businessRegistrationFile != null}');
    debugPrint('Business license file: ${businessLicenseFile != null}');

    if (_validateCurrentForm()) {
      debugPrint('Form validation passed. Creating multipart request...');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://906c-89-41-26-60.ngrok-free.app/api/register-driver'),
      );

      // Add text fields
      request.fields.addAll({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'phone_number': '0${widget.phoneNum?.replaceAll(' ', '') ?? ''}',
        'city': selectedCity,
        'password': passwordController.text,
        'vehicle_make': makeController.text,
        'vehicle_model': modelController.text,
        'vehicle_color': colorController.text,
        'vehicle_year': yearController.text,
        'license_number': licenseNoController.text,
        'license_plate': licensePlateController.text,
        'license_country': selectedCountry,
        'license_issue_date': licenseIssueDate.toIso8601String(),
        'license_expiry_date': licenseExpiryDate.toIso8601String(),
        'tin': tinController.text,
      });
      debugPrint('Added text fields: ${request.fields}');

      // Add files
      Future<void> addFile(String field, PlatformFile? file) async {
        if (file != null) {
          debugPrint('Attempting file upload for $field: ${file.name}');

          // Determine the MIME type based on the file extension
          final String? extension = file.extension?.toLowerCase();
          final String mimeType;

          if (extension == 'jpg' || extension == 'jpeg') {
            mimeType = 'image/jpeg';
          } else if (extension == 'png') {
            mimeType = 'image/png';
          } else if (extension == 'pdf') {
            mimeType = 'application/pdf';
          } else {
            mimeType = 'application/octet-stream'; // Fallback for unknown types
          }

          // Split the MIME type into type and subtype
          final List<String> mimeParts = mimeType.split('/');
          final MediaType contentType = MediaType(mimeParts[0], mimeParts[1]);

          if (kIsWeb) {
            debugPrint('Using bytes for web-based upload...');
            request.files.add(http.MultipartFile.fromBytes(
              field,
              file.bytes!,
              filename: file.name,
              contentType: contentType,
            ));
          } else {
            debugPrint('Using file path upload for mobile...');
            request.files.add(await http.MultipartFile.fromPath(
              field,
              file.path!,
              filename: file.name,
              contentType: contentType,
            ));
          }
        }
      }

      await addFile('profile_photo', profilePhotoFile);
      await addFile('vehicle_ownership', vehicleOwnershipFile);
      await addFile('libre', libreFile);
      await addFile('insurance', insuranceFile);
      await addFile('business_registration', businessRegistrationFile);
      await addFile('business_license', businessLicenseFile);

      try {
        debugPrint('Sending request...');
        final response = await request.send();
        debugPrint('Request completed with status: ${response.statusCode}');
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 204) {
          debugPrint('Request succeeded, navigating to home...');
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  driver: Driver(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phoneNumber:
                        '0${widget.phoneNum?.replaceAll(' ', '') ?? ''}',
                  ),
                ),
              ),
            );
          }
        } else {
          debugPrint('Request failed: ${response.reasonPhrase}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${response.reasonPhrase}')),
            );
          }
        }
      } catch (e) {
        debugPrint('Something went wrong: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    } else {
      debugPrint('Validation failed, not submitting request.');
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
                        child: DriverInfoForm(
                          phoneNum: widget.phoneNum,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                          selectedCity: selectedCity,
                          onCityChanged: (newCity) =>
                              setState(() => selectedCity = newCity),
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          onProfilePhotoSelected: (file) =>
                              setState(() => profilePhotoFile = file),
                        ),
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
                        child: VehicleInfoForm(
                          makeController: makeController,
                          modelController: modelController,
                          colorController: colorController,
                          yearController: yearController,
                          licenseNoController: licenseNoController,
                          licensePlateController: licensePlateController,
                          selectedCountry: selectedCountry,
                          onCountryChanged: (country) =>
                              setState(() => selectedCountry = country),
                          licenseIssueDate: licenseIssueDate,
                          licenseExpiryDate: licenseExpiryDate,
                          onIssueDateChanged: (date) =>
                              setState(() => licenseIssueDate = date),
                          onExpiryDateChanged: (date) =>
                              setState(() => licenseExpiryDate = date),
                        ),
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
                        child: Documents(
                          tinController: tinController,
                          onVehicleOwnershipSelected: (file) =>
                              setState(() => vehicleOwnershipFile = file),
                          onLibreSelected: (file) =>
                              setState(() => libreFile = file),
                          onInsuranceSelected: (file) =>
                              setState(() => insuranceFile = file),
                          onBusinessRegistrationSelected: (file) =>
                              setState(() => businessRegistrationFile = file),
                          onBusinessLicenseSelected: (file) =>
                              setState(() => businessLicenseFile = file),
                        ),
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
