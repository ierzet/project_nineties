import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';

abstract class MemberRemoteDataSource {
  Future<String> insertData(MemberModel params);
  Future<String> updateData(MemberModel params);
  Future<String> uploadImage(MemberModel params);
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData();
  Stream<List<MemberEntity>> getMembersStream();
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  MemberRemoteDataSourceImpl(this.instance, this.firebaseStorage);

  FirebaseFirestore instance = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  Stream<List<MemberEntity>> getMembersStream() {
    var result = instance.collection('member').snapshots().map((snapshot) {
      try {
        final members = snapshot.docs.map((doc) {
          return MemberModel.fromFirestore(doc).toEntity();
        }).toList();
        return members;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    });
    //TODO:rapihin handler error nya
    return result;
  }

  @override
  Future<String> uploadImage(MemberModel dataModel) async {
    String downloadUrl = '';
    try {
      // Create a unique file name
      String fileName =
          'member/vehicle_images/${dataModel.memberNoVehicle}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // Create a reference to the location where you want to upload the file
      Reference ref = firebaseStorage.ref(fileName);

      // Check if memberPhotoOfVehicleFile is not null
      if (dataModel.memberPhotoOfVehicleFile != null) {
        // Upload the bytes directly
        await ref.putData(dataModel
            .memberPhotoOfVehicleFile!); // Use the non-null assertion operator
      } else {
        throw Exception("No image data available to upload.");
      }

      // Optionally, get the download URL
      downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw FirebaseStorageFailure.fromCode(e.code);
    } catch (e) {
      if (e is FirebaseStorageFailure) {
        rethrow;
      } else {
        throw const FirebaseStorageFailure();
      }
    }
  }

  @override
  Future<String> insertData(MemberModel params) async {
    try {
      //print('params DS: ${params.memberJoinPartner}');
      final docRef = instance.collection('member').doc();
      await docRef.set(params.toFireStore());
      return 'Data member berhasil ditambahkan';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<String> updateData(MemberModel dataModel) async {
    try {
      // print('params DS: ${dataModel.memberJoinPartner}');
      final docRef = instance.collection('member').doc(dataModel.memberId);
      await docRef.set(dataModel.toFireStore());
      return 'Data member berhasil diperbarui';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() async {
    try {
      final result = await instance.collection('member').get();
      return result;
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }
}

//File file = File(image.path);
