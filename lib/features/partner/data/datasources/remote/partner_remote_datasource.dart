import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

abstract class PartnerRemoteDataSource {
  Future<String> insertData(PartnerModel dataModel);
  Future<String> updateData(PartnerModel dataModel);
  Future<String> uploadImage(PartnerModel dataModel);
  Future<List<PartnerModel>> fetchData();
  Stream<List<PartnerEntity>> getPartnersStream();
}

class PartnerRemoteDataSourceImpl implements PartnerRemoteDataSource {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage;
  final Dio dio;
  PartnerRemoteDataSourceImpl(this.instance, this._firebaseStorage, this.dio);

  @override
  Future<String> insertData(PartnerModel dataModel) async {
    return AppBackendConfig.writeBackend == BackendType.firebase
        ? _insertPartnerDataToFirebase(dataModel)
        : _insertPartnerDataToMongoDB(dataModel);
  }

  @override
  Future<String> updateData(PartnerModel dataModel) async {
    return AppBackendConfig.writeBackend == BackendType.firebase
        ? _updateDataToFirebase(dataModel)
        : _updateDataToMongoDB(dataModel);
  }

  @override
  Future<List<PartnerModel>> fetchData() async {
    return AppBackendConfig.writeBackend == BackendType.firebase
        ? _fetchDataToFirebase()
        : _fetchDataToMongoDB();
  }

  @override
  Stream<List<PartnerEntity>> getPartnersStream() {
    return AppBackendConfig.writeBackend == BackendType.firebase
        ? _getPartnersStreamToFirebase()
        : _getPartnersStreamToMongoDB();
  }

  Stream<List<PartnerEntity>> _getPartnersStreamToFirebase() {
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

  Stream<List<PartnerEntity>> _getPartnersStreamToMongoDB() async* {
    const String baseUrl =
        'http://192.168.1.11:3000'; // Replace with your server's IP or domain
    const String url = '$baseUrl/api/partners/';

    while (true) {
      try {
        // Retrieve the token from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('jwt_token');

        // Add headers
        dio.options.headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        // Send GET request
        final Response response = await dio.get(url);

        if (response.statusCode == 200) {
          // Convert response data into a list of PartnerModel
          final List<dynamic> data = response.data['data'];
          final List<PartnerEntity> partners = data
              .map((json) => PartnerModel.fromJson(json).toEntity())
              .toList();

          // Yield the fetched data as a stream event
          yield partners;
        } else {
          throw Exception(
              'Failed to fetch partners: ${response.statusCode} - ${response.statusMessage}');
        }
      } on DioException catch (e) {
        if (e.response != null) {
          debugPrint(
              'DioError: ${e.response?.statusCode} - ${e.response?.data}');
        } else {
          debugPrint('DioError: ${e.message}');
        }
        throw Exception(
            'Error fetching data: ${e.response?.statusCode ?? e.message}');
      } catch (e) {
        throw Exception('Unexpected error occurred: $e');
      }

      // Add a delay to simulate periodic updates or polling
      await Future.delayed(const Duration(seconds: 1));
    }
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

  /////////////////////////////////////////////////////////////////////////////

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

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String> _insertPartnerDataToMongoDB(PartnerModel dataModel) async {
    saveToken(AppBackendConfig.token);

    const String baseUrl =
        'http://192.168.1.11:3000'; // Replace localhost with your local IP
    const String url = '$baseUrl/api/partners/';

    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('jwt_token');

      // Add headers
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      // Send POST request
      final Response response = await dio.post(
        url,
        data: dataModel.toJson(), // Serialize the model into JSON
      );

      // Check the response status
      if (response.statusCode == 201) {
        print('Partner created: ${response.data}');
        return 'Data mitra berhasil ditambahkan';
      } else {
        print(
            'Failed to create partner: ${response.statusCode} - ${response.data}');
        throw const FireBaseCatchFailure(); // Handle error
      }
    } on DioException catch (e) {
      // Dio-specific error handling
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('DioError: ${e.message}');
      }
      throw const FireBaseCatchFailure();
    } catch (e) {
      // Handle any other exceptions
      print('Error: $e');
      throw const FireBaseCatchFailure();
    }
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<String> _updateDataToFirebase(PartnerModel dataModel) async {
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

  Future<String> _updateDataToMongoDB(PartnerModel dataModel) async {
    saveToken(AppBackendConfig.token);
    const String baseUrl =
        'http://192.168.1.11:3000'; // Replace localhost with your local IP
    final String url = '$baseUrl/api/partners/${dataModel.partnerId}';
    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('jwt_token');

      // Add headers
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      // print(dataModel.toJson());
      // Send POST request
      final Response response = await dio.patch(
        url,
        data: dataModel.toJson(), // Serialize the model into JSON
      );
      // print('response.statusMessage: ${response.statusMessage}');
      // Check the response status
      if (response.statusCode == 200) {
        // print('Partner created: ${response.data}');
        return 'Data mitra berhasil diperbarui';
      } else {
        // print(
        //     'Failed to create partner: ${response.statusCode} - ${response.data}');
        throw const FireBaseCatchFailure(); // Handle error
      }
    } on DioException catch (e) {
      // Dio-specific error handling
      if (e.response != null) {
        debugPrint('DioError: ${e.response?.statusCode} - ${e.response?.data}');
        throw Exception('Error fetching data: ${e.response?.statusCode}');
      } else {
        debugPrint('DioError: ${e.message}');
        throw const ConnectionFailure('Failed to connect to the network');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw const FireBaseCatchFailure();
    }
  }

  Future<List<PartnerModel>> _fetchDataToFirebase() async {
    try {
      final querySnapshot =
          await instance.collection(AppCollection.partnerCollection).get();
      final result = querySnapshot.docs
          .map((doc) => PartnerModel.fromFirestore(doc))
          .toList();
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

  Future<List<PartnerModel>> _fetchDataToMongoDB() async {
    saveToken(AppBackendConfig.token);
    const String baseUrl =
        'http://192.168.1.11:3000'; // Replace with your server's IP or domain
    const String url =
        '$baseUrl/api/partners/'; // API endpoint to fetch partners

    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('jwt_token');

      // Add headers
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      // Send GET request
      final Response response = await dio.get(url);

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Convert response data into a list of PartnerModel
        final List<dynamic> data = response.data['data'];
        final List<PartnerModel> partners =
            data.map((json) => PartnerModel.fromJson(json)).toList();

        return partners;
      } else {
        // Handle other response statuses
        throw Exception(
            'Failed to fetch partners: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Dio-specific error handling
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode} - ${e.response?.data}');
        throw Exception('Error fetching data: ${e.response?.statusCode}');
      } else {
        print('DioError: ${e.message}');
        throw const ConnectionFailure('Failed to connect to the network');
      }
    } catch (e) {
      print('Error: $e');
      throw const FireBaseCatchFailure();
    }
  }
}
