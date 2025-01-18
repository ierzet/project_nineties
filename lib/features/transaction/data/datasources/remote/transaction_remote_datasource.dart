import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/transaction/data/models/transaction_model.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionRemoteDataSource {
  Future<MemberModel> getMember(String param);
  Future<String> addTransaction(TransactionModel params);
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData();
  Stream<List<TransactionEntity>> getTransactionsStream();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  TransactionRemoteDataSourceImpl(this.instance);
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Stream<List<TransactionEntity>> getTransactionsStream() {
    var result = instance.collection('transaction').snapshots().map((snapshot) {
      try {
        final transactions = snapshot.docs.map((doc) {
          return TransactionModel.fromFirestore(doc).toEntity();
        }).toList();
        return transactions;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    });
    //TODO:rapihin handler error nya
    return result;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() async {
    try {
      final result = await instance.collection('transaction').get();
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

  @override
  Future<MemberModel> getMember(String param) async {
    try {
      final docSnapshot = await instance.collection('member').doc(param).get();

      if (!docSnapshot.exists) {
        throw const FireBaseCatchFailure('Member not found');
      }

      final result = MemberModel.fromFirestore(docSnapshot);
      return result;
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('Failed to connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<String> addTransaction(TransactionModel params) async {
    try {
      await instance.collection('transaction').doc().set(params.toFirestore());
      return 'Succsesss';
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
