import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/home/data/model/home_model.dart';

abstract class HomeRemoteDatasource {
  Future<HomeModel> countMember(HomeModel initialHomeModel);
  Future<HomeModel> countPartners(HomeModel initialHomeModel);
  Future<HomeModel> countUsers(HomeModel initialHomeModel);
  Future<HomeModel> countTransactions(HomeModel initialHomeModel);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  HomeRemoteDatasourceImpl(this.instance);
  FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  Future<HomeModel> countMember(HomeModel initialHomeModel) async {
    // Initialize the homeModel as empty

    try {
      // Create a query to the 'member' collection
      Query<Map<String, dynamic>> query =
          instance.collection(AppCollection.memberCollection);

      // Get the count of members
      final members = await query.count().get();

      // Create a new HomeModel with the total members count
      final HomeModel updatedHomeModel =
          initialHomeModel.copyWith(totalMembers: members.count);

      // Return the updated HomeModel
      return updatedHomeModel;
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
  Future<HomeModel> countPartners(HomeModel initialHomeModel) async {
    // Initialize the homeModel as empty

    try {
      // Create a query to the 'member' collection
      Query<Map<String, dynamic>> query = instance.collection('partner');

      // Get the count of members
      final partners = await query.count().get();

      // Create a new HomeModel with the total members count
      final HomeModel updatedHomeModel =
          initialHomeModel.copyWith(totalPartners: partners.count);

      // Return the updated HomeModel
      return updatedHomeModel;
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
  Future<HomeModel> countTransactions(HomeModel initialHomeModel) async {
    try {
      // Create a query to the  collection
      Query<Map<String, dynamic>> query = instance.collection('transaction');

      // Get the count of members
      final transactions = await query.count().get();

      // Create a new HomeModel with the total  count
      final HomeModel updatedHomeModel =
          initialHomeModel.copyWith(totalTransactions: transactions.count);

      // Return the updated HomeModel
      return updatedHomeModel;
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
  Future<HomeModel> countUsers(HomeModel initialHomeModel) async {
    try {
      // Create a query to the  collection
      Query<Map<String, dynamic>> query = instance.collection('user_account');

      // Get the count of members
      final users = await query.count().get();

      // Create a new HomeModel with the total  count
      final HomeModel updatedHomeModel =
          initialHomeModel.copyWith(totalUsers: users.count);

      // Return the updated HomeModel
      return updatedHomeModel;
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
}
