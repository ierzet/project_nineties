import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_entity.dart';
import 'package:universal_html/html.dart' as html;

abstract class UserRemoteDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers();
  Future<String> approvalUser(UserAccountModel params);
  Future<String> registerUser(UserParams params);
  Stream<List<UserAccountEntity>> getUsersStream();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(
      this.instance, this._firebaseAuth, this._firebaseStorage);
  FirebaseFirestore instance = FirebaseFirestore.instance;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  @override
  Stream<List<UserAccountEntity>> getUsersStream() {
    var result =
        instance.collection('user_account').snapshots().map((snapshot) {
      try {
        final users = snapshot.docs.map((doc) {
          return UserAccountModel.fromFirestore(doc).toEntity();
        }).toList();
        return users;
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    });
    //TODO:rapihin handler error nya
    return result;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers() async {
    try {
      final result = await instance.collection('user_account').get();

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
  Future<String> approvalUser(UserAccountModel params) async {
    try {
      await instance
          .collection('user_account')
          .doc(params.user.id)
          .set(params.approvalUser());
      return 'user ${params.user.name} has been approval';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }

  @override
  Future<String> registerUser(UserParams params) async {
    try {
      //signup user and password
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: params.email, password: params.password);

      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const SignUpWithEmailAndPasswordFailure(
            'User registration failed');
      }

      //upload file image to firebasestorage
      String downloadUrl = '';
      if (params.isWeb == true && params.avatarFileWeb != null) {
        final blob = html.Blob([params.avatarFileWeb!]);
        var snapshot = await _firebaseStorage
            .ref()
            .child('user_image/user_profile/${user.uid}')
            .putBlob(blob);
        downloadUrl = await snapshot.ref.getDownloadURL();
      } else if (params.avatarFile != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child('user_image/user_profile/${user.uid}')
            .putFile(params.avatarFile!);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      //update link photo profile dan display name firbaseauth
      user.updateProfile(
        displayName: params.name,
        photoURL: downloadUrl.isNotEmpty ? downloadUrl : null,
      );

      //create user
      final userEntity = UserEntity(
        id: user.uid,
        email: user.email,
        name: params.name,
        photo: downloadUrl.isNotEmpty ? downloadUrl : null,
      );

      //create UserAccountModel
      final userAccount = UserAccountModel(
        user: userEntity,
        isActive: true,
        partner: params.partner,
        roleId: params.roleId,
        createdBy: params.createdBy,
      );

      // set value user_account to firebasestorage
      await instance
          .collection('user_account')
          .doc(userAccount.user.id)
          .set(userAccount.initiateUserAccountByADminToFireStore());

      // kirim email notification
      await user.sendEmailVerification();

      //logout
      await _firebaseAuth.signOut();

      final message = 'user ${params.name} has been approval';

      return message;
    } on FirebaseAuthException catch (e) {
      // await _firebaseAuth.signOut();
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } on SocketException {
      await _firebaseAuth.signOut();
      throw const ConnectionFailure('failed connect to the network');
    } on FirebaseException catch (e) {
      await _firebaseAuth.signOut();
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (e) {
      if (e is SignUpWithEmailAndPasswordFailure) {
        await _firebaseAuth.signOut();
        rethrow;
      } else {
        await _firebaseAuth.signOut();
        throw const SignUpWithEmailAndPasswordFailure();
      }
    }
  }
}
