import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

import 'package:universal_html/html.dart';

class PartnerPlatformAvatarPicker extends StatefulWidget {
  const PartnerPlatformAvatarPicker({super.key});

  @override
  State<PartnerPlatformAvatarPicker> createState() =>
      _PartnerPlatformAvatarPickerState();
}

class _PartnerPlatformAvatarPickerState
    extends State<PartnerPlatformAvatarPicker> {
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
    try {
      final pickedFile = await ImagePickerWeb.getImageAsFile();
      if (pickedFile != null) {
        _webImage = await loadImage(pickedFile);
        setState(() {
          _webImage = _webImage;
          final currentState =
              context.read<PartnerValidatorBloc>().state.partnerParams;
          context.read<PartnerValidatorBloc>().add(PartnerValidatorForm(
              partnerParams:
                  currentState.copyWith(partnerAvatarFileWeb: pickedFile)));
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
      _webImage = null;
      final currentState =
          context.read<PartnerValidatorBloc>().state.partnerParams;
      context.read<PartnerValidatorBloc>().add(PartnerValidatorForm(
          partnerParams: currentState.copyWith(partnerAvatarFileWeb: null)));
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
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: const Column(
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
              ),
            ),
    );
  }
}
