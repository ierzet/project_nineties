import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';

class PlatformAvatarPicker extends StatefulWidget {
  const PlatformAvatarPicker({super.key});

  @override
  State<PlatformAvatarPicker> createState() => _PlatformAvatarPickerState();
}

class _PlatformAvatarPickerState extends State<PlatformAvatarPicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final newImage = File(pickedFile.path);
        setState(() {
          _image = newImage;
          final currentState = context.read<AuthValidatorCubit>().state;
          context.read<AuthValidatorCubit>().validateSignupCredentials(
                email: currentState.email,
                password: currentState.password,
                name: currentState.name,
                confirmedPassword: currentState.confirmedPassword,
                avatarFile: _image,
                isWeb: false,
              );
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      final currentState = context.read<AuthValidatorCubit>().state;
      context.read<AuthValidatorCubit>().validateSignupCredentials(
            email: currentState.email,
            password: currentState.password,
            name: currentState.name,
            confirmedPassword: currentState.confirmedPassword,
            avatarFile: null,
            isWeb: false,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: _image != null
          ? Stack(
              children: [
                ClipOval(
                  child: Image.file(
                    _image!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _removeImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt,
                      color: AppColors.secondary, size: 50),
                  const SizedBox(height: 8),
                  Text(
                    "Tap to add photo",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
    );
  }
}
