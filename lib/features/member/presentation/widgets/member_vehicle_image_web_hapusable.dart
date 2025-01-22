import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberPlatformVehicleImagePicker extends StatefulWidget {
  const MemberPlatformVehicleImagePicker({super.key});

  @override
  State<MemberPlatformVehicleImagePicker> createState() =>
      _MemberPlatformVehicleImagePickerState();
}

class _MemberPlatformVehicleImagePickerState
    extends State<MemberPlatformVehicleImagePicker> {
  final ImagePicker picker = ImagePicker();
  Uint8List? imageBytes; // Using Uint8List to store image bytes

  Future<void> pickImage() async {
    final memberParams = context.read<MemberValidatorBloc>().state.data;
    final snackBarCatchErrror = ScaffoldMessenger.of(context);
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Convert the image file to bytes
        final bytes = await image.readAsBytes();

        // Update the member entity with the image bytes
        MemberEntity updatedParams =
            memberParams.copyWith(memberPhotoOfVehicleFile: bytes);

        // Upload the image to Firebase
        // await uploadImageToFirebase(bytes);

        setState(() {
          context
              .read<MemberValidatorBloc>()
              .add(MemberValidatorForm(params: updatedParams));
          imageBytes = bytes; // Update state with image bytes
        });
      }
    } catch (e) {
      // Handle any errors that might occur during image picking
      snackBarCatchErrror.showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> uploadImageToFirebase(Uint8List bytes) async {
    try {
      // Create a reference to the Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      // Create a unique file name
      String fileName =
          'member/vehicle_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      // Create a reference to the location where you want to upload the file
      Reference ref = storage.ref(fileName);
      // Upload the bytes directly
      await ref.putData(bytes);
      // Optionally, get the download URL
    } catch (e) {
      debugPrint('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: GestureDetector(
        onTap: pickImage,
        child: Container(
          width: double.infinity.w,
          height: 150.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: imageBytes == null
              ? const Center(child: Text('Tap to upload vehicle photo'))
              : Image.memory(
                  imageBytes!, // Display the image from bytes
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
