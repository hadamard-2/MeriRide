import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:meri_ride/my_text_field.dart';

class Documents extends StatelessWidget {
  const Documents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          spacing: 20,
          children: [
            Flexible(child: FileBrowser(labelText: 'Vehicle Ownership')),
            Flexible(child: FileBrowser(labelText: 'Libre')),
          ],
        ),
        const Flexible(child: FileBrowser(labelText: 'Insurance')),
        const Divider(),
        const Row(
          spacing: 20,
          children: [
            Flexible(child: FileBrowser(labelText: 'Business Registration')),
            Flexible(child: FileBrowser(labelText: 'Business License')),
          ],
        ),
        MyTextField(
          text: 'TIN',
          prefixIcon: const Icon(Icons.account_balance_rounded),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
          ],
          validator: validateTIN,
        )
      ],
    );
  }

  String? validateTIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'TIN is required';
    }
    if (value.length != 12) {
      return 'TIN must be exactly 12 characters';
    }
    return null;
  }
}

class FileBrowser extends StatefulWidget {
  final String labelText;
  final int maxFileSize;

  const FileBrowser({
    super.key,
    required this.labelText,
    this.maxFileSize = 5 * 1024 * 1024, // Default to 5MB
  });

  @override
  FileBrowserState createState() => FileBrowserState();
}

class FileBrowserState extends State<FileBrowser> {
  PlatformFile? selectedFile;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;

      if (file.size > widget.maxFileSize) {
        // Convert bytes to MB for display
        double maxSizeMB = widget.maxFileSize / (1024 * 1024);
        String maxSizeStr =
            maxSizeMB.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');

        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('File too large'),
            content: Text(
              'The selected file exceeds the maximum allowed size of $maxSizeStr MB. '
              'Please choose a smaller file.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return; // Disregard the file if it's too large
      }

      setState(() {
        selectedFile = file;
      });
      debugPrint(selectedFile?.name);
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.description_rounded, size: 20),
              const SizedBox(width: 8),
              Text(
                selectedFile != null
                    ? '${selectedFile?.name.substring(0, 10)}...'
                    : 'Select File',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
