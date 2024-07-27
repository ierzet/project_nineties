import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';
import 'dart:io';

class PlatformAvatarPicker extends StatefulWidget {
  const PlatformAvatarPicker({super.key});

  @override
  State<PlatformAvatarPicker> createState() => _PlatformAvatarPickerState();
}

class _PlatformAvatarPickerState extends State<PlatformAvatarPicker> {
  File? _image;

  Future<void> _pickImage() async {
    final colorScheme = Theme.of(context).colorScheme;
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final newImage = File(pickedFile.path);
        setState(() {
          _image = newImage;
          final currentState =
              context.read<AuthenticationValidatorBloc>().state.params;
          context
              .read<AuthenticationValidatorBloc>()
              .add(AuthenticationValidatorForm(
                  params: currentState.copyWith(
                avatarFile: _image,
                isWeb: false,
              )));
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.error,
          content: Text(
            '${AppStrings.failedToPickImage}: $e',
            style: TextStyle(
              color: colorScheme.onError,
            ),
          ),
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      final currentState =
          context.read<AuthenticationValidatorBloc>().state.params;
      context
          .read<AuthenticationValidatorBloc>()
          .add(AuthenticationValidatorForm(
              params: currentState.copyWith(
            avatarFile: null,
            isWeb: false,
          )));
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
                    height: AppPadding.triplePadding.h * 3,
                    width: AppPadding.triplePadding.w * 3,
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
                        // color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        //color: Colors.white,
                        size: AppPadding.halfPadding.r * 3,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: AppPadding.triplePadding.h * 3,
              width: AppPadding.triplePadding.w * 3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: AppPadding.triplePadding.h,
                  ),
                  SizedBox(height: AppPadding.halfPadding.h),
                  Text(
                    "ambil gambar",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
