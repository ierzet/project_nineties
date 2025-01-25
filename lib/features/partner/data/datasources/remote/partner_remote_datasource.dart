import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:universal_html/html.dart' as html;

abstract class PartnerRemoteDataSource {
  Future<String> insertData(PartnerModel dataModel);
  Future<String> updateData(PartnerModel dataModel);
  Future<String> uploadImage(PartnerModel dataModel);
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData();
  Stream<List<PartnerEntity>> getPartnersStream();
}

class PartnerRemoteDataSourceImpl implements PartnerRemoteDataSource {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage;

  PartnerRemoteDataSourceImpl(this.instance, this._firebaseStorage);

  @override
  Stream<List<PartnerEntity>> getPartnersStream() {
    var result = instance
        .collection(AppCollection.partnerCollection)
        .snapshots()
        .map((snapshot) {
      try {
        final partners = snapshot.docs.map((doc) {
          return PartnerModel.fromFirestore(doc).toEntity();
        }).toList();
        return partners;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    });
    //TODO:rapihin handler error nya
    return result;
  }

  @override
  Future<String> uploadImage(PartnerModel dataModel) async {
    try {
      String downloadUrl = '';
      if (kIsWeb && dataModel.partnerAvatarFileWeb != null) {
        final blob = html.Blob([dataModel.partnerAvatarFileWeb!]);
        // Upload dataImage to FirebaseStorage
        var snapshot = await _firebaseStorage
            .ref()
            .child(
                'user_image/partner_profile/${dataModel.partnerEmail}_${DateTime.now().millisecondsSinceEpoch}')
            .putBlob(blob);
        downloadUrl = await snapshot.ref.getDownloadURL();
      } else if (dataModel.partnerAvatarFile != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child(
                'user_image/partner_profile/${dataModel.partnerEmail}_${DateTime.now().millisecondsSinceEpoch}')
            .putFile(dataModel.partnerAvatarFile!);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }
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

  // @override
  // Future<String> insertData(PartnerModel dataModel) async {
  //   try {
  //     final docRef = instance
  //         .collection(AppCollection.partnerCollection)
  //         .doc(dataModel.partnerEmail);
  //     final docSnapshot = await docRef.get();

  //     // validasi id partner dengan email
  //     if (docSnapshot.exists) {
  //       //TODO: tambahin mekanisme hapus image file yang berhasi terupload
  //       throw const FireBaseCatchFailure(
  //           'Data mitra sudah ada silakan gunakan email yang lain');
  //     }

  //     //4 Save dataModel to Firestore
  //     await docRef.set(dataModel.toFireStore());
  //     return 'Data mitra berhasil ditambahkan';
  //   } on FirebaseException catch (e) {
  //     throw FireBaseCatchFailure.fromCode(e.code);
  //   } on SocketException {
  //     throw const ConnectionFailure('failed connect to the network');
  //   } catch (e) {
  //     if (e is FireBaseCatchFailure) {
  //       rethrow;
  //     } else {
  //       throw const FireBaseCatchFailure();
  //     }
  //   }
  // }
  /////////////////////////////////////////////////////////////////////////////
  @override
  Future<String> insertData(PartnerModel dataModel) async {
    return AppBackendConfig.writeBackend == BackendType.firebase
        ? _insertPartnerDataToFirebase(dataModel)
        : _insertPartnerDataToMongoDB(dataModel);
  }

  Future<String> _insertPartnerDataToFirebase(PartnerModel dataModel) async {
    try {
      final docRef = instance
          .collection(AppCollection.partnerCollection)
          .doc(dataModel.partnerEmail);
      final docSnapshot = await docRef.get();

      // validasi id partner dengan email
      if (docSnapshot.exists) {
        //TODO: tambahin mekanisme hapus image file yang berhasi terupload
        throw const FireBaseCatchFailure(
            'Data mitra sudah ada silakan gunakan email yang lain');
      }

      //4 Save dataModel to Firestore
      await docRef.set(dataModel.toFireStore());
      return 'Data mitra berhasil ditambahkan';
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

  Future<String> _insertPartnerDataToMongoDB(PartnerModel dataModel) async {
    throw const FireBaseCatchFailure();
  }

  /////////////////////////////////////////////////////////////////////////////
  @override
  Future<String> updateData(PartnerModel dataModel) async {
    try {
      final docRef = instance
          .collection(AppCollection.partnerCollection)
          .doc(dataModel.partnerEmail);

      await docRef.set(dataModel.toFireStore());
      return 'Data mitra berhasil diperbarui';
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
      final result =
          await instance.collection(AppCollection.partnerCollection).get();
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
