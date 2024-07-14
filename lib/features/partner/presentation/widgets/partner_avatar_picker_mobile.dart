import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

class PartnerPlatformAvatarPicker extends StatefulWidget {
  const PartnerPlatformAvatarPicker({super.key});

  @override
  State<PartnerPlatformAvatarPicker> createState() =>
      _PartnerPlatformAvatarPickerState();
}

class _PartnerPlatformAvatarPickerState
    extends State<PartnerPlatformAvatarPicker> {
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
          final currentState =
              context.read<PartnerValidatorBloc>().state.partnerParams;
          context.read<PartnerValidatorBloc>().add(PartnerValidatorForm(
                partnerParams: currentState.copyWith(partnerAvatarFile: _image),
              ));
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
      final currentState =
          context.read<PartnerValidatorBloc>().state.partnerParams;
      context.read<PartnerValidatorBloc>().add(PartnerValidatorForm(
            partnerParams: currentState.copyWith(partnerAvatarFile: null),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final partnerImageUrl = context
        .read<PartnerValidatorBloc>()
        .state
        .partnerParams
        .partnerImageUrl;

    Widget avatarWidget;
    if (_image != null) {
      avatarWidget = Image.file(
        _image!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else if (partnerImageUrl.isNotEmpty) {
      avatarWidget = Image.network(
        partnerImageUrl,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      avatarWidget = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            size: 50,
          ),
          SizedBox(height: 8),
          Text(
            "Tap to add photo",
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: _pickImage,
      child: _image != null || partnerImageUrl.isNotEmpty
          ? Stack(
              children: [
                ClipOval(
                  child: avatarWidget,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _removeImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
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
                // color: Colors.grey[200],
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: avatarWidget,
            ),
    );
  }
}
