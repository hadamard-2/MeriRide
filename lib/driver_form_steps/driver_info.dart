import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meri_ride/my_password_field.dart';
import 'package:meri_ride/phone_num_text_field.dart';

class DriverInfoForm extends StatefulWidget {
  final String? phoneNum;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String selectedCity;
  final ValueChanged<String> onCityChanged;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueChanged<PlatformFile?> onProfilePhotoSelected;

  const DriverInfoForm({
    super.key,
    this.phoneNum,
    required this.firstNameController,
    required this.lastNameController,
    required this.selectedCity,
    required this.onCityChanged,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onProfilePhotoSelected,
  });

  @override
  State<DriverInfoForm> createState() => _DriverInfoFormState();
}

class _DriverInfoFormState extends State<DriverInfoForm> {
  late TextEditingController phoneNumController;
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
  PlatformFile? _profilePhotoFile;
  final double _maxProfilePhotoSize = 2 * 1024 * 1024; // 2MB

  Future<void> _pickProfilePhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.size > _maxProfilePhotoSize) {
        _showErrorDialog('Profile photo cannot exceed 2MB');
        return;
      }

      if (!['jpg', 'jpeg', 'png'].any(file.extension!.contains)) {
        _showErrorDialog('Only JPG/JPEG/PNG files allowed');
        return;
      }

      setState(() => _profilePhotoFile = file);
      widget.onProfilePhotoSelected(file);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid File'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    phoneNumController = TextEditingController(text: widget.phoneNum);
    currentValue = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        ProfilePhotoField(
          profilePhotoFile: _profilePhotoFile,
          onPickPhoto: _pickProfilePhoto,
        ),
        const SizedBox(),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.firstNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'First name is required';
                  } else if (value.trim().length < 3) {
                    return 'First name must be at least 3 characters long';
                  } else if (value.trim().length > 50) {
                    return 'First name cannot be longer than 50 characters';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: widget.lastNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Last name is required';
                  } else if (value.trim().length < 3) {
                    return 'Last name must be at least 3 characters long';
                  } else if (value.trim().length > 50) {
                    return 'Last name cannot be longer than 50 characters';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        PhoneNumTextField(phoneNumController: phoneNumController),
        DropdownButtonFormField(
          value: widget.selectedCity,
          onChanged: (value) => widget.onCityChanged(value.toString()),
          hint: const Text('City', style: TextStyle(fontSize: 14.5)),
          items: cities.map((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          // onChanged: (newValue) {
          //   setState(() {
          //     currentValue = newValue.toString();
          //   });
          // },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'City is required';
            }
            return null;
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_on_rounded),
            border: OutlineInputBorder(),
          ),
        ),
        const Divider(thickness: 1.5),
        MyPasswordField(
          controller: widget.passwordController,
          label: 'Password',
        ),
        MyPasswordField(
          controller: widget.confirmPasswordController,
          label: 'Confirm Password',
        ),
      ],
    );
  }
}

class ProfilePhotoField extends StatefulWidget {
  final PlatformFile? profilePhotoFile;
  final Future<void> Function() onPickPhoto;

  const ProfilePhotoField({
    super.key,
    required this.profilePhotoFile,
    required this.onPickPhoto,
  });

  @override
  State<ProfilePhotoField> createState() => _ProfilePhotoFieldState();
}

class _ProfilePhotoFieldState extends State<ProfilePhotoField> {
  ImageProvider? _getImageProvider() {
    if (widget.profilePhotoFile == null) return null;

    if (kIsWeb) {
      if (widget.profilePhotoFile?.bytes != null) {
        return MemoryImage(Uint8List.fromList(widget.profilePhotoFile!.bytes!));
      }
      return null;
    } else {
      if (widget.profilePhotoFile?.path != null) {
        return FileImage(File(widget.profilePhotoFile!.path!));
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FormField<PlatformFile>(
        key: ValueKey(kIsWeb
            ? widget.profilePhotoFile?.name
            : widget.profilePhotoFile?.path),
        initialValue: widget.profilePhotoFile,
        validator: (value) {
          if (value == null) return 'Profile photo is required';
          return null;
        },
        builder: (formFieldState) => Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(60),
              onTap: () async {
                await widget.onPickPhoto();
                if (mounted) {
                  formFieldState.didChange(widget.profilePhotoFile);
                  formFieldState.validate();
                }
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade400,
                backgroundImage: _getImageProvider(),
                child: widget.profilePhotoFile == null
                    ? const Icon(
                        Icons.person_rounded,
                        size: 90,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  formFieldState.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
