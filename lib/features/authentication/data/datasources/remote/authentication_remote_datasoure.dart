import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/authentication/data/models/user_account_model.dart';
import 'package:project_nineties/features/authentication/data/models/user_moodel.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';

import 'package:universal_html/html.dart' as html;

abstract class AuthenticationRemoteDataSource {
  Future<String> signUpEmailAndPassword(RegisterAuthentication credential);
  Future<User> loginEmailAndPassword(String email, String password);
  Future<UserModel> isAuthenticated();
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

  @override
  Future<String> signUpEmailAndPassword(
    RegisterAuthentication credential,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: credential.email,
        password: credential.password,
      );

      final user = _firebaseAuth.currentUser;
      if (user != null) {
        if (credential.isWeb != null && credential.isWeb == true) {
          // Web
          if (credential.avatarWeb != null) {
            // Convert Uint8List to Blob
            final blob = html.Blob([credential.avatarWeb!]);

            // Upload to Firebase Storage
            var snapshot = await _firebaseStorage
                .ref()
                .child('user_image/user_profile/${user.uid}')
                .putBlob(blob);

            // Get download URL
            String downloadUrl = await snapshot.ref.getDownloadURL();

            // Update user photo URL
            await user.updatePhotoURL(downloadUrl);

            // Prepare user account data
            final userAccountData = {
              'email': credential.email,
              'name': credential.name,
              'photo': downloadUrl,
              'mitra_id': credential.mitraId,
            };

            // Save to Firestore
            await _firestore
                .collection('UserAccount')
                .doc(user.uid)
                .set(userAccountData);
          } else {
            // Avatar web is null
            final userAccountData = {
              'email': credential.email,
              'name': credential.name,
              'photo': '',
              'mitra_id': credential.mitraId,
            };
            await _firestore
                .collection('UserAccount')
                .doc(user.uid)
                .set(userAccountData);
          }
        } else {
          // Mobile
          if (credential.avatar != null) {
            var snapshot = await _firebaseStorage
                .ref()
                .child('user_image/user_profile/${user.uid}')
                .putFile(credential.avatar!);

            String downloadUrl = await snapshot.ref.getDownloadURL();

            await user.updatePhotoURL(downloadUrl);

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
          } else {
            final userAccountData = {
              'email': credential.email,
              'name': credential.name,
              'photo': '',
              'mitra_id': credential.mitraId,
            };
            await _firestore
                .collection('UserAccount')
                .doc(user.uid)
                .set(userAccountData);
          }
        }
      } else {
        // User is null after registration
        debugPrint('User is null after registration');
      }

      return 'User has been registered';
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (error) {
      debugPrint('Exception: $error');
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<User> loginEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
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

  @override
  Future<UserModel> isAuthenticated() async {
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

  @override
  Future<UserModel> authenticateEmailAndPassword(
      LoginAuthentication credential) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: credential.email, password: credential.password);
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

  @override
  Future<UserModel> authenticateGoogleSignin() async {
    debugPrint('AuthenticationRemoteDataSourceImpl');
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider
            .setCustomParameters({'login_hint': 'example@example.com'});

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
    try {
      if (kIsWeb) {
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();
        facebookProvider.addScope('email');
        facebookProvider.setCustomParameters({'display': 'popup'});

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(facebookProvider);
        final currentUser = userCredential.user;

        if (currentUser != null) {
          final user = UserModel.fromFirebaseUser(currentUser);
          return user;
        } else {
          throw const LogInWithGoogleFailure(
              'Current user is null after authentication.');
        }
      } else {
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

  @override
  Future<UserAccountModel> updateUserAccountFireStore() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        final userAccount = UserAccountModel.fromFirebaseUser(currentUser);
        final userAccountData = {
          'email': userAccount.email,
          'name': userAccount.name,
          'photo': userAccount.photo,
        };
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

  @override
  Future<String> onLogOut() async {
    try {
      await _firebaseAuth.signOut();
      return 'LogOut Succed';
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthInitializeFailure.fromCode(e.code);
    } catch (_) {
      throw const AuthInitializeFailure();
    }
  }
}


  // Future<String> signUpEmailAndPassword(
  //     RegisterAuthentication credential, io.File? imageData) async {
  //   try {
  //     print('signUpEmailAndPassword');
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: credential.email,
  //       password: credential.password,
  //     );
  //     print('createUserWithEmailAndPassword');
  //     final user = _firebaseAuth.currentUser;

  //     if (user != null) {
  //       user.updateDisplayName(credential.name);

  //       if (imageData != null) {
  //         // final reader = html.FileReader();
  //         // reader.readAsDataUrl(imageData);
  //         var snapshot = await _firebaseStorage
  //             .ref()
  //             .child('user_image/user_profile')
  //             .putBlob(imageData);
  //         String downloadUrl = await snapshot.ref.getDownloadURL();
  //         user.updatePhotoURL(downloadUrl);
  //         final userAccountData = {
  //           'email': credential.email,
  //           'name': credential.name,
  //           'photo': downloadUrl,
  //           'mitra_id': credential.mitraId,
  //         };
  //         print('userAccountData: $userAccountData');
  //         await _firestore
  //             .collection('UserAccount')
  //             .doc(user.uid)
  //             .set(userAccountData);
  //         print('_firestore');
  //       }
  //     }
  //     print('user has been registered');
  //     return 'user has been registered';
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
  //   } catch (error) {
  //     throw const SignUpWithEmailAndPasswordFailure();
  //   }
  // }

  //check authentication status from firebase auth
 