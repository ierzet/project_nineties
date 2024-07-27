import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';

class UserPlatformAvatarPicker extends StatefulWidget {
  const UserPlatformAvatarPicker({super.key});

  @override
  State<UserPlatformAvatarPicker> createState() =>
      _UserPlatformAvatarPickerState();
}

class _UserPlatformAvatarPickerState extends State<UserPlatformAvatarPicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final newImage = File(pickedFile.path);
        setState(() {
          _image = newImage;
          final currentState = context.read<UserValidatorBloc>().state.params;
          context.read<UserValidatorBloc>().add(UserValidatorForm(
                  params: currentState.copyWith(
                avatarFile: _image,
                isWeb: false,
              )));
        });
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      final currentState = context.read<UserValidatorBloc>().state.params;
      context.read<UserValidatorBloc>().add(UserValidatorForm(
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
                    height: AppPadding.triplePadding.r * 3,
                    width: AppPadding.triplePadding.r * 3,
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
                        size: AppPadding.halfPadding.r * 2,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: AppPadding.triplePadding.h * 3,
              width: AppPadding.triplePadding.w * 3,
              decoration: const BoxDecoration(
                //color: Colors.grey[200],
                shape: BoxShape.circle,
                // border: Border.all(
                //   color: Colors.red[400]!,
                //   width: 2,
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    // color: AppColors.secondary,
                    size: AppPadding.triplePadding,
                  ),
                  SizedBox(height: AppPadding.halfPadding.h),
                  const Text(
                    "Tap to add photo",
                    style: TextStyle(
                        //  color: Colors.grey[800],
                        ),
                  ),
                ],
              ),
            ),
    );
  }
}
