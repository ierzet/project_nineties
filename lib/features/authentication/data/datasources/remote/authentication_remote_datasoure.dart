import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/data/models/user_moodel.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' show Platform;

abstract class AuthenticationRemoteDataSource {
  Future<String> signUpEmailAndPassword(
      RegisterAuthentication credential, html.File? imageData);
  Future<User> loginEmailAndPassword(String email, String password);
  Future<UserModel> isAuthencticated();
  Future<UserModel> authenticateEmailAndPassword(
      LoginAuthentication credential);
  Future<UserModel> authenticateGoogleSignin();
  Future<UserModel> authenticateFacebookSignin();

  Future<UserAccountModel> updateUserAccountFireStore();
  String updateUserAccountFireStoreX();

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataById(String userId);
  Future<String> onLogOut();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  AuthenticationRemoteDataSourceImpl(
      this._firebaseAuth, this._firestore, this._firebaseStorage);
//sign up email and password to firebase auth
  @override
  Future<String> signUpEmailAndPassword(
      RegisterAuthentication credential, html.File? imageData) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: credential.email,
        password: credential.password,
      );

      final user = _firebaseAuth.currentUser;

      if (user != null) {
        user.updateDisplayName(credential.name);

        if (imageData != null) {
          final reader = html.FileReader();
          reader.readAsDataUrl(imageData);
          var snapshot = await _firebaseStorage
              .ref()
              .child('user_image/user_profile')
              .putBlob(imageData);
          String downloadUrl = await snapshot.ref.getDownloadURL();
          user.updatePhotoURL(downloadUrl);
          final userAccountData = {
            'email': credential.email,
            'name': credential.name,
            'photo': downloadUrl,
            'mitra_id': credential.mitraId,
          };
          await _firestore
              .collection('UserAccount')
              .doc(user.uid)
              .set(userAccountData);
        }

        //TODO:Temporary, add UserAccount. next should move to proper usecase, and doc should be replace with id
      }

      return 'user has been registered';
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (error) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  //check authentication status from firebase auth
  @override
  Future<UserModel> isAuthencticated() async {
    try {
      final firebaseUser = await _firebaseAuth.authStateChanges().first;

      final userModel = firebaseUser == null
          ? UserModel.empty
          : UserModel.fromFirebaseUser(firebaseUser);

      return userModel;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthInitializeFailure.fromCode(e.code);
    } catch (_) {
      throw const AuthInitializeFailure();
    }
  }

  bool isWeb() {
    return kIsWeb;
  }

  bool isIOS() {
    return !kIsWeb && Platform.isIOS;
  }

  //log in with email and password firebase auth
  @override
  Future<UserModel> authenticateEmailAndPassword(
      LoginAuthentication credential) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: credential.email,
        password: credential.password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }

    final currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      final user = UserModel.fromFirebaseUser(currentUser);
      return user;
    } else {
      throw const LogInWithEmailAndPasswordFailure(
          'Current user is null after authentication.');
    }
  }

//log in with google firebase auth
  @override
  Future<UserModel> authenticateGoogleSignin() async {
    debugPrint('AuthenticationRemoteDataSourceImpl');
    try {
      if (isWeb()) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider
            .setCustomParameters({'login_hint': 'example@example.com'});

        // Trigger the authentication flow using a popup
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);
        final currentUser = userCredential.user;

        if (currentUser != null) {
          final user = UserModel.fromFirebaseUser(currentUser);
          return user;
        } else {
          throw const LogInWithGoogleFailure(
              'Current user is null after authentication.');
        }
      } else {
        // Mobile platforms
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await _firebaseAuth.signInWithCredential(credential);
        }

        final currentUser = _firebaseAuth.currentUser;

        if (currentUser != null) {
          final user = UserModel.fromFirebaseUser(currentUser);
          return user;
        } else {
          throw const LogInWithGoogleFailure(
              'Current user is null after authentication.');
        }
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<UserModel> authenticateFacebookSignin() async {
    debugPrint('AuthenticationRemoteDataSourceImpl');

    // try {
    //   if (isWeb()) {
    //     GoogleAuthProvider googleProvider = GoogleAuthProvider();
    //     googleProvider
    //         .addScope('https://www.googleapis.com/auth/contacts.readonly');
    //     googleProvider
    //         .setCustomParameters({'login_hint': 'example@example.com'});

    //     // Trigger the authentication flow using a popup
    //     UserCredential userCredential =
    //         await FirebaseAuth.instance.signInWithPopup(googleProvider);
    //     final currentUser = userCredential.user;

    //     if (currentUser != null) {
    //       final user = UserModel.fromFirebaseUser(currentUser);
    //       return user;
    //     } else {
    //       throw const LogInWithGoogleFailure(
    //           'Current user is null after authentication.');
    //     }
    //   } else {
    //     // Mobile platforms
    //     final GoogleSignIn googleSignIn = GoogleSignIn();
    //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    //     if (googleUser != null) {
    //       final GoogleSignInAuthentication googleAuth =
    //           await googleUser.authentication;

    //       final AuthCredential credential = GoogleAuthProvider.credential(
    //         accessToken: googleAuth.accessToken,
    //         idToken: googleAuth.idToken,
    //       );
    //       await _firebaseAuth.signInWithCredential(credential);
    //     }

    //     final currentUser = _firebaseAuth.currentUser;

    //     if (currentUser != null) {
    //       final user = UserModel.fromFirebaseUser(currentUser);
    //       return user;
    //     } else {
    //       throw const LogInWithGoogleFailure(
    //           'Current user is null after authentication.');
    //     }
    //   }
    // } on FirebaseAuthException catch (e) {
    //   throw LogInWithGoogleFailure.fromCode(e.code);
    // } catch (_) {
    //   throw const LogInWithGoogleFailure();
    // }
    try {
      if (isWeb()) {
        print('web');
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();

        facebookProvider.addScope('email');
        facebookProvider.setCustomParameters({
          'display': 'popup',
        });
        print(facebookProvider);
        // Trigger the authentication flow using a popup
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(facebookProvider);
        final currentUser = userCredential.user;
        print('ke sini ga');
        if (currentUser != null) {
          print('ada user fbnya');
          final user = UserModel.fromFirebaseUser(currentUser);
          return user;
        } else {
          print('ga ada user fbnya');
          throw const LogInWithGoogleFailure(
              'Current user is null after authentication.');
        }
      } else {
        print('mobile');
        // Mobile platforms
        final LoginResult result = await FacebookAuth.instance.login();

        if (result.status == LoginStatus.success) {
          final AccessToken accessToken = result.accessToken!;
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(accessToken.tokenString);

          UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(facebookAuthCredential);
          final currentUser = userCredential.user;

          if (currentUser != null) {
            final user = UserModel.fromFirebaseUser(currentUser);
            return user;
          } else {
            throw const LogInWithGoogleFailure(
                'Current user is null after authentication.');
          }
        } else {
          throw const LogInWithGoogleFailure('Facebook login failed.');
        }
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  //create user account in firestore for the  first time login
  @override
  Future<UserAccountModel> updateUserAccountFireStore() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        // print('User ID: ${currentUser.uid}');
        // print('User email: ${currentUser.email}');
        // print('User display name: ${currentUser.displayName}');
        // print('User photo URL: ${currentUser.photoURL}');
        // print('User tenantId: ${currentUser.tenantId}');
        // print('User metadataL: ${currentUser.metadata}');
        // print('User multiFactor: ${currentUser.multiFactor}');
        // print('All data from currentUser: $currentUser');
        final userAccount = UserAccountModel.fromFirebaseUser(currentUser);
        // Store the UserAccount data in Firestore
        final userAccountData = {
          'email': userAccount.email,
          'name': userAccount.name,
          'photo': userAccount.photo,
        };
        // Replace 'users' with the actual Firestore collection where you want to store user accounts
        await _firestore
            .collection('UserAccount')
            .doc(userAccount.userId)
            .set(userAccountData);
        return userAccount;
      } else {
        throw const LogInWithEmailAndPasswordFailure(
            'Current user is null after authentication.');
      }
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }

  @override
  String updateUserAccountFireStoreX() {
    return 'abcd';
  }

  //get user account by id from firestore
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataById(
      String userId) async {
    try {
      final result =
          await _firestore.collection('UserAccount').doc(userId).get();
      return result;
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }

  // log out from firebase auth
  @override
  Future<String> onLogOut() async {
    try {
      unawaited(_firebaseAuth.signOut());
      return 'LogOut Succed';
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthInitializeFailure.fromCode(e.code);
    } catch (_) {
      throw const AuthInitializeFailure();
    }
  }

  @override
  Future<User> loginEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = _firebaseAuth.currentUser;

      if (result != null) {
        return result;
      } else {
        throw const LogInWithEmailAndPasswordFailure(
            'Current user is null after authentication.');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }
}
