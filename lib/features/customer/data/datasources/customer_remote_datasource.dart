import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/customer/data/models/customer_model.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';

abstract class CustomerRemoteDataSource {
  Future<String> insertData(CustomerModel params);
  Future<String> updateData(CustomerModel params);
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData();
  Stream<List<CustomerEntity>> getCustomersStream();
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  CustomerRemoteDataSourceImpl(this.instance);

  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Stream<List<CustomerEntity>> getCustomersStream() {
    var result = instance.collection('customer').snapshots().map((snapshot) {
      try {
        final customers = snapshot.docs.map((doc) {
          return CustomerModel.fromFirestore(doc).toEntity();
        }).toList();
        return customers;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    });
    //TODO:rapihin handler error nya
    return result;
  }

  @override
  Future<String> insertData(CustomerModel params) async {
    try {
      final docRef = instance.collection('customer').doc();
      await docRef.set(params.toFireStore());
      return 'Data customer berhasil ditambahkan';
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
  Future<String> updateData(CustomerModel dataModel) async {
    try {
      final docRef = instance.collection('customer').doc(dataModel.customerId);
      await docRef.set(dataModel.toFireStore());
      return 'Data customer berhasil diperbarui';
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
      final result = await instance.collection('customer').get();
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
