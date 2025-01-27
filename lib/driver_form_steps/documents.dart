import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:meri_ride/my_text_field.dart';

class Documents extends StatelessWidget {
  final TextEditingController tinController;
  final ValueChanged<PlatformFile?> onVehicleOwnershipSelected;
  final ValueChanged<PlatformFile?> onLibreSelected;
  final ValueChanged<PlatformFile?> onInsuranceSelected;
  final ValueChanged<PlatformFile?> onBusinessRegistrationSelected;
  final ValueChanged<PlatformFile?> onBusinessLicenseSelected;

  const Documents({
    super.key,
    required this.tinController,
    required this.onVehicleOwnershipSelected,
    required this.onLibreSelected,
    required this.onInsuranceSelected,
    required this.onBusinessRegistrationSelected,
    required this.onBusinessLicenseSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 20,
          children: [
            Flexible(
              child: RequiredFileBrowser(
                onFileSelected: onVehicleOwnershipSelected,
                labelText: 'Vehicle Ownership',
              ),
            ),
            Flexible(
              child: RequiredFileBrowser(
                onFileSelected: onLibreSelected,
                labelText: 'Libre',
              ),
            ),
          ],
        ),
        Flexible(
          child: RequiredFileBrowser(
            onFileSelected: onInsuranceSelected,
            labelText: 'Insurance',
          ),
        ),
        const Divider(),
        Row(
          spacing: 20,
          children: [
            Flexible(
              child: RequiredFileBrowser(
                onFileSelected: onBusinessRegistrationSelected,
                labelText: 'Business Registration',
              ),
            ),
            Flexible(
              child: RequiredFileBrowser(
                onFileSelected: onBusinessLicenseSelected,
                labelText: 'Business License',
              ),
            ),
          ],
        ),
        MyTextField(
          controller: tinController,
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

class RequiredFileBrowser extends StatelessWidget {
  final String labelText;
  final int maxFileSize;
  final void Function(PlatformFile?) onFileSelected;

  const RequiredFileBrowser({
    super.key,
    required this.labelText,
    required this.onFileSelected,
    this.maxFileSize = 5 * 1024 * 1024,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<PlatformFile>(
      validator: (value) {
        if (value == null) {
          return '$labelText is required';
        }
        return null;
      },
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FileBrowser(
              labelText: labelText,
              maxFileSize: maxFileSize,
              onFileSelected: (file) {
                onFileSelected(file);
                formFieldState.didChange(file);
              },
            ),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Text(
                  formFieldState.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class FileBrowser extends StatefulWidget {
  final String labelText;
  final int maxFileSize;
  final ValueChanged<PlatformFile?>? onFileSelected;

  const FileBrowser({
    super.key,
    required this.labelText,
    this.maxFileSize = 5 * 1024 * 1024,
    this.onFileSelected,
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
        double maxSizeMB = widget.maxFileSize / (1024 * 1024);
        String maxSizeStr =
            maxSizeMB.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');

        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('File too large'),
            content: Text(
              'The selected file exceeds the maximum allowed size of $maxSizeStr MB.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      setState(() => selectedFile = file);
      widget.onFileSelected?.call(selectedFile);
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
                selectedFile?.name != null
                    ? '${selectedFile!.name.substring(0, selectedFile!.name.length.clamp(0, 10))}...'
                    : 'Select File',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
