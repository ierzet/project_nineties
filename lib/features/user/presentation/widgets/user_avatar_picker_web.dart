import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';
import 'package:universal_html/html.dart';

class UserPlatformAvatarPicker extends StatefulWidget {
  const UserPlatformAvatarPicker({super.key});

  @override
  State<UserPlatformAvatarPicker> createState() =>
      _UserPlatformAvatarPickerState();
}

class _UserPlatformAvatarPickerState extends State<UserPlatformAvatarPicker> {
  Uint8List? _webImage;

  Future<Uint8List?> loadImage(File file) async {
    final reader = FileReader();
    final completer = Completer<Uint8List>();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((_) {
      completer.complete(reader.result as Uint8List);
    });
    return completer.future;
  }

  Future<void> _pickImage() async {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final pickedFile = await ImagePickerWeb.getImageAsFile();
      if (pickedFile != null) {
        _webImage = await loadImage(pickedFile);
        setState(() {
          _webImage = _webImage;
          final currentState = context.read<UserValidatorBloc>().state.params;
          context.read<UserValidatorBloc>().add(UserValidatorForm(
                  params: currentState.copyWith(
                avatarFileWeb: pickedFile,
                isWeb: true,
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
      _webImage = null;
      // Handle the Cubit state update for web
      final currentState = context.read<UserValidatorBloc>().state.params;

      context.read<UserValidatorBloc>().add(UserValidatorForm(
              params: currentState.copyWith(
            avatarFileWeb: null,
            isWeb: true,
          )));
    });
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
                        //   color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        // color: Colors.white,
                        size: AppPadding.halfPadding.r * 2,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                // color: Colors.grey[200],
                shape: BoxShape.circle,
                // border: Border.all(
                //   color: Colors.grey[400]!,
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
                        //   color: Colors.grey[800],
                        ),
                  ),
                ],
              ),
            ),
    );
  }
}
