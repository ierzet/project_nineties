import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';
import 'package:universal_html/html.dart';

class PlatformAvatarPicker extends StatefulWidget {
  const PlatformAvatarPicker({super.key});

  @override
  State<PlatformAvatarPicker> createState() => _PlatformAvatarPickerState();
}

class _PlatformAvatarPickerState extends State<PlatformAvatarPicker> {
  Uint8List? _webImage;

  Future<Uint8List?> loadImage(File file) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    final res = await reader.onLoad.first;
    print('${res.total} bytes loaded');
    return reader.result as Uint8List;
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePickerWeb.getImageAsFile();
      if (pickedFile != null) {
        print('1. pickedFile => pick file : $pickedFile');
        _webImage = await loadImage(pickedFile);
        setState(() {
          _webImage = _webImage;
          print(
              '2. _webImage => setState dan convert ke-Uint8List: ${_webImage!.isNotEmpty}');
          final currentState = context.read<AuthValidatorCubit>().state;
          context.read<AuthValidatorCubit>().validateSignupCredentials(
              email: currentState.email,
              password: currentState.password,
              name: currentState.name,
              confirmedPassword: currentState.confirmedPassword,
              avatarFile: currentState.avatarFile,
              avatarFileWeb: pickedFile,
              isWeb: true);
        });
        print(
            '4. avatarFileWeb => ambil data dari state cubit ${context.read<AuthValidatorCubit>().state.avatarFileWeb}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _webImage = null;
      print(
          '5. _webImage => akan dii set null jika image di remove, apakah null :$_webImage ');
      // Handle the Cubit state update for mobile
      final currentState = context.read<AuthValidatorCubit>().state;
      context.read<AuthValidatorCubit>().validateSignupCredentials(
          email: currentState.email,
          password: currentState.password,
          name: currentState.name,
          confirmedPassword: currentState.confirmedPassword,
          avatarFile: currentState.avatarFile,
          avatarFileWeb: null,
          isWeb: true);
    });
    print(
        '4. avatarFileWeb => ambil data dari state cubit, indikator null: ${context.read<AuthValidatorCubit>().state.avatarFileWeb.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: _webImage != null
          ? Stack(
              children: [
                ClipOval(
                  child: Image.memory(
                    _webImage!,
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
