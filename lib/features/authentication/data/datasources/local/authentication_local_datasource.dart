import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future updateAuthSharedPreference();
  Future<String> getData();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationLocalDataSourceImpl(this._firebaseAuth);
  @override
  Future updateAuthSharedPreference() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        final userAccountModel = UserAccountModel.fromFirebaseUser(currentUser);
        final userAccountJson = userAccountModel.toJson();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userAccount', json.encode(userAccountJson));
      } else {
        throw const SharedPreferenceFailure(
            'Current user is null after authentication.');
      }
    } catch (e) {
      if (e is SharedPreferenceFailure) {
        await _firebaseAuth.signOut();
        rethrow;
      } else {
        await _firebaseAuth.signOut();
        throw SharedPreferenceFailure(e.toString());
      }
    }
  }

  @override
  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataUserAccount = prefs.getString('userAccount');
    if (dataUserAccount != null) {
      return dataUserAccount;
    } else {
      return 'data kosong';
    }
  }
}
