import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class VehicleInfoForm extends StatelessWidget {
  const VehicleInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 20,
      children: [
        Row(
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
            MyTextField(text: 'Make', prefixIcon: Icon(Icons.directions_car)),
            MyTextField(text: 'Model', prefixIcon: Icon(Icons.garage_rounded)),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            MyTextField(text: 'Color', prefixIcon: Icon(Icons.color_lens)),
            MyTextField(text: 'Year', prefixIcon: Icon(Icons.calendar_today)),
          ],
        ),
        Divider(),
        Row(
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
                text: 'License No.', prefixIcon: Icon(Icons.numbers_rounded)),
            MyTextField(
                text: 'License Plate',
                prefixIcon: Icon(Icons.confirmation_num_rounded)),
          ],
        ),
        CountryPicker(labelText: 'License Country'),
        Row(
          spacing: 20,
          children: [
            DatePicker(labelText: 'License Issue Date'),
            DatePicker(labelText: 'License Expiry Date'),
          ],
        ),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final String text;
  final Icon prefixIcon;

  const MyTextField({super.key, required this.text, required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: text,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class CountryPicker extends StatefulWidget {
  final String labelText;

  const CountryPicker({super.key, required this.labelText});

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  String selectedCountry = 'Ethiopia';

  selectCountry(Country newSelection) {
    setState(() {
      selectedCountry = newSelection.name;
    });
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
              Text(selectedCountry),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final String labelText;

  const DatePicker({super.key, required this.labelText});

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
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
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
