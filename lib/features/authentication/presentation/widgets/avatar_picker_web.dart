import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';

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
    final completer = Completer<Uint8List>();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((_) {
      completer.complete(reader.result as Uint8List);
    });
    return completer.future;
  }

  Future<void> _pickImage() async {
    final colorScheme = Theme.of(context).colorScheme;
    try {
      final pickedFile = await ImagePickerWeb.getImageAsFile();
      if (pickedFile != null) {
        _webImage = await loadImage(pickedFile);
        setState(() {
          _webImage = _webImage;
          final currentState =
              context.read<AuthenticationValidatorBloc>().state.params;
          context
              .read<AuthenticationValidatorBloc>()
              .add(AuthenticationValidatorForm(
                  params: currentState.copyWith(
                avatarFileWeb: pickedFile,
                isWeb: true,
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
      _webImage = null;
      // Handle the Cubit state update for web
      final currentState =
          context.read<AuthenticationValidatorBloc>().state.params;

      context
          .read<AuthenticationValidatorBloc>()
          .add(AuthenticationValidatorForm(
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
                        //   color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        // color: Colors.white,
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
