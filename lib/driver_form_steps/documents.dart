import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meri_ride/my_text_field.dart';

class Documents extends StatelessWidget {
  const Documents({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 20,
          children: [
            Flexible(child: FileBrowser(labelText: 'Vehicle Ownership')),
            Flexible(child: FileBrowser(labelText: 'Libre')),
          ],
        ),
        Flexible(child: FileBrowser(labelText: 'Insurance')),
        Divider(),
        Row(
          spacing: 20,
          children: [
            Flexible(child: FileBrowser(labelText: 'Business Registration')),
            Flexible(child: FileBrowser(labelText: 'Business License')),
          ],
        ),
        MyTextField(
            text: 'TIN', prefixIcon: Icon(Icons.account_balance_rounded))
      ],
    );
  }
}

class FileBrowser extends StatefulWidget {
  final String labelText;

  const FileBrowser({super.key, required this.labelText});

  @override
  FileBrowserState createState() => FileBrowserState();
}

class FileBrowserState extends State<FileBrowser> {
  late PlatformFile selectedFile;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFile = result.files.single;

      debugPrint(selectedFile.name);
    }
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
          onTap: _selectFile,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.description_rounded, size: 20),
              SizedBox(width: 8),
              Text('Select File'),
            ],
          ),
        ),
      ),
    );
  }
}
