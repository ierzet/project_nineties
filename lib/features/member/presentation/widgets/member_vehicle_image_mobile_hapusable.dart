import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class MemberPlatformVehicleImagePicker extends StatefulWidget {
  const MemberPlatformVehicleImagePicker({super.key});

  @override
  State<MemberPlatformVehicleImagePicker> createState() =>
      _MemberPlatformVehicleImagePickerState();
}

class _MemberPlatformVehicleImagePickerState
    extends State<MemberPlatformVehicleImagePicker> {
  final ImagePicker picker = ImagePicker();
  Uint8List? imageBytes; // Menggunakan Uint8List untuk menyimpan byte gambar

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Mengonversi file gambar menjadi byte
        final bytes = await image.readAsBytes();
        setState(() {
          imageBytes = bytes; // Update state dengan byte gambar
        });
      }
    } catch (e) {
      // Handle any errors that might occur during image picking
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: GestureDetector(
        onTap: pickImage,
        child: Container(
          width: double.infinity, // Use full width
          height: 150.h, // Fixed height for mobile
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: imageBytes == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt, // Icon to indicate image upload
                      size: 40.h,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h),
                    const Text(
                      'Tap to upload vehicle photo',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              : Image.memory(
                  imageBytes!, // Menampilkan gambar dari byte
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
