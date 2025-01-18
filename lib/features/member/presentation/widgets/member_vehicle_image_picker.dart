import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberVehicleImagePicker extends StatefulWidget {
  const MemberVehicleImagePicker({super.key, this.isEnabled});
  final bool? isEnabled;

  @override
  State<MemberVehicleImagePicker> createState() =>
      _MemberVehicleImagePickerState();
}

class _MemberVehicleImagePickerState extends State<MemberVehicleImagePicker> {
  final ImagePicker picker = ImagePicker();
  Uint8List? imageBytes; // Using Uint8List to store image bytes
  bool isChange = false;

  Future<void> pickImage() async {
    if (widget.isEnabled != true) return; // Disable picking if not enabled

    final memberParams = context.read<MemberValidatorBloc>().state.data;
    final memberValidatorForm = context.read<MemberValidatorBloc>();
    final snackBarCatchError = ScaffoldMessenger.of(context);

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Convert the image file to bytes
        final bytes = await image.readAsBytes();

        // Update the member entity with the image bytes
        MemberEntity updatedParams =
            memberParams.copyWith(memberPhotoOfVehicleFile: bytes);

        setState(() {
          isChange = true;
          imageBytes = bytes; // Update state with image bytes
        });

        // Update the bloc with the new parameters
        memberValidatorForm.add(MemberValidatorForm(params: updatedParams));
      }
    } catch (e) {
      // Handle any errors that might occur during image picking
      snackBarCatchError.showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the current state of the MemberValidatorBloc directly
    final memberParams = context.read<MemberValidatorBloc>().state.data;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: GestureDetector(
        onTap: pickImage,
        child: Container(
          width: double.infinity.w,
          height: 150.h,
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.isEnabled == true
                    ? Colors.grey
                    : Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
            color: widget.isEnabled == true
                ? Colors.transparent
                : Colors.grey
                    .shade200, // Optional: Change background color when disabled
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(8), // Match the container's border radius
            child: memberParams.memberPhotoOfVehicle != null &&
                    isChange == false
                ? Image.network(
                    memberParams.memberPhotoOfVehicle!,
                    fit: BoxFit.cover,
                    width: double.infinity, // Ensure the image takes full width
                    height:
                        double.infinity, // Ensure the image takes full height
                  )
                : imageBytes == null
                    ? const Center(child: Text('Tap to upload vehicle photo'))
                    : Image.memory(
                        imageBytes!, // Display the image from bytes
                        fit: BoxFit.cover,
                        width: double
                            .infinity, // Ensure the image takes full width
                        height: double
                            .infinity, // Ensure the image takes full height
                      ),
          ),
        ),
      ),
    );
  }
}
