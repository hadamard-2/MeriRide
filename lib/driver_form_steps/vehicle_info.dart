import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:meri_ride/my_text_field.dart';

class VehicleInfoForm extends StatelessWidget {
  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController colorController;
  final TextEditingController yearController;
  final TextEditingController licenseNoController;
  final TextEditingController licensePlateController;
  final String selectedCountry;
  final ValueChanged<String> onCountryChanged;
  final DateTime licenseIssueDate;
  final DateTime licenseExpiryDate;
  final ValueChanged<DateTime> onIssueDateChanged;
  final ValueChanged<DateTime> onExpiryDateChanged;

  const VehicleInfoForm({
    super.key,
    required this.makeController,
    required this.modelController,
    required this.colorController,
    required this.yearController,
    required this.licenseNoController,
    required this.licensePlateController,
    required this.selectedCountry,
    required this.onCountryChanged,
    required this.licenseIssueDate,
    required this.licenseExpiryDate,
    required this.onIssueDateChanged,
    required this.onExpiryDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        const Row(
          children: [
            Text(
              'Vehicle',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            MyTextField(
              controller: makeController,
              text: 'Make',
              prefixIcon: const Icon(Icons.directions_car),
              validator: _validateMakeModel,
            ),
            MyTextField(
              controller: modelController,
              text: 'Model',
              prefixIcon: const Icon(Icons.garage_rounded),
              validator: _validateMakeModel,
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            MyTextField(
              controller: colorController,
              text: 'Color',
              prefixIcon: const Icon(Icons.color_lens),
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
              ],
              validator: _validateColor,
            ),
            MyTextField(
              controller: yearController,
              text: 'Year',
              prefixIcon: const Icon(Icons.calendar_today),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              validator: _validateYear,
            ),
          ],
        ),
        const Divider(),
        const Row(
          children: [
            Text(
              'License',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            MyTextField(
              controller: licenseNoController,
              text: 'License No.',
              prefixIcon: const Icon(Icons.numbers_rounded),
              inputFormatters: [LengthLimitingTextInputFormatter(9)],
              validator: _validateLicenseNumber,
            ),
            MyTextField(
              controller: licensePlateController,
              text: 'License Plate',
              prefixIcon: const Icon(Icons.confirmation_num_rounded),
              inputFormatters: [
                UpperCaseTextFormatter(),
                LengthLimitingTextInputFormatter(6),
              ],
              validator: _validateLicensePlate,
            ),
          ],
        ),
        CountryPicker(
          selectedCountry: selectedCountry,
          onCountrySelected: onCountryChanged,
          labelText: 'License Country',
        ),
        Row(
          spacing: 20,
          children: [
            DatePicker(
              selectedDate: licenseIssueDate,
              onDateSelected: onIssueDateChanged,
              labelText: 'License Issue Date',
              firstDate: DateTime.now().subtract(const Duration(days: 5 * 365)),
              lastDate: DateTime.now(),
            ),
            DatePicker(
              selectedDate: licenseExpiryDate,
              onDateSelected: onExpiryDateChanged,
              labelText: 'License Expiry Date',
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 5 * 365)),
            ),
          ],
        ),
      ],
    );
  }

  static String? _validateMakeModel(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value.length < 3 || value.length > 25) {
      return 'Must be between 3 and 25 characters';
    }
    return null;
  }

  static String? _validateYear(String? value) {
    if (value == null || value.isEmpty) return 'Year is required';
    final int year = int.tryParse(value) ?? 0;
    if (year < 1886 || year > DateTime.now().year) {
      return 'Year must be between 1886 and ${DateTime.now().year}';
    }
    return null;
  }

  static String? _validateLicenseNumber(String? value) {
    if (value == null || value.isEmpty) return 'License Number is required';
    if (!RegExp(r'^\d{2}-\d{6}$').hasMatch(value)) {
      return 'Please enter a valid license number (e.g., 12-345678)';
    }
    return null;
  }

  static String? _validateLicensePlate(String? value) {
    if (value == null || value.isEmpty) return 'License Plate is required';
    if (!RegExp(r'^[A-Za-z]?\d{5}$').hasMatch(value)) {
      return 'Please enter a valid license plate (e.g., A12345 or 12345)';
    }
    return null;
  }

  static String? _validateColor(String? value) {
    if (value == null || value.isEmpty) return 'Color is required';
    if (value.length < 3 || value.length > 25) {
      return 'Must be between 3 and 25 characters';
    }
    return null;
  }
}

class CountryPicker extends StatefulWidget {
  final String labelText;
  final String selectedCountry;
  final void Function(String) onCountrySelected;

  const CountryPicker({
    super.key,
    required this.labelText,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  selectCountry(Country newSelection) {
    widget.onCountrySelected(newSelection.name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              countryListTheme: const CountryListThemeData(
                emojiFontFamilyFallback: ['NotoColorEmoji'],
                flagSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 20),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              onSelect: selectCountry,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.flag_rounded, size: 20),
              const SizedBox(width: 8),
              Text(widget.selectedCountry),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final String labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;

  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;

  const DatePicker({
    super.key,
    required this.labelText,
    this.firstDate,
    this.lastDate,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime pickedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null && picked != pickedDate) {
      setState(() => pickedDate = picked);
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: InkWell(
            onTap: () => _selectDate(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text("${pickedDate.toLocal()}".split(' ')[0]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
