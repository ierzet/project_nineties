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
import 'package:project_nineties/features/authentication/data/models/user_model.dart';
import 'package:project_nineties/features/authentication/domain/usecases/login_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:universal_html/html.dart' as html;

abstract class AuthenticationRemoteDataSource {
  Future<String> signUpEmailAndPassword(RegisterAuthentication credential);
  Future<UserModel> authenticateEmailAndPassword(
      LoginAuthentication credential);
  Future<UserModel> authenticateGoogleSignin();
  Future<UserModel> authenticateFacebookSignin();
  Future<UserAccountModel> updateUserAccountFireStore();
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataById(String userId);
  Future<UserAccountModel> getUserAccountById(String uid);
  Future<String> onLogOut();
  Future<String> resetPassword(String email);
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
          email: credential.email, password: credential.password);

      final user = _firebaseAuth.currentUser;
      if (user == null) {
        debugPrint('User is null after registration');
        return 'User registration failed';
      }

      String downloadUrl = '';
      if (credential.isWeb == true && credential.avatarWeb != null) {
        final blob = html.Blob([credential.avatarWeb!]);
        var snapshot = await _firebaseStorage
            .ref()
            .child('user_image/user_profile/${user.uid}')
            .putBlob(blob);
        downloadUrl = await snapshot.ref.getDownloadURL();
      } else if (credential.avatar != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child('user_image/user_profile/${user.uid}')
            .putFile(credential.avatar!);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      await user.updateProfile(
        displayName: credential.name,
        photoURL: downloadUrl.isNotEmpty ? downloadUrl : null,
      );

      final userAccountData = {
        'email': credential.email,
        'name': credential.name,
        'photo': downloadUrl,
        'mitra_id': credential.mitraId,
        'isInitiate': true,
      };

      await _firestore
          .collection('UserAccount')
          .doc(user.uid)
          .set(userAccountData);

      // Send email verification
      await user.sendEmailVerification();

      await _firebaseAuth.signOut();

      return 'User has been registered. Please verify your email address.';
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (error) {
      debugPrint('Exception: $error');
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<UserModel> authenticateEmailAndPassword(
      LoginAuthentication credential) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: credential.email, password: credential.password);
      final user = _firebaseAuth.currentUser;

      //menggunakan verifikasi email
      // if (user == null || !user.emailVerified) {
      //   await _firebaseAuth.signOut();
      //   throw LogInWithEmailAndPasswordFailure(user == null
      //       ? 'Current user is null after authentication.'
      //       : 'Please verify your email address to log in.');
      // }
      //tanpa verifikasi email
      if (user == null) {
        await _firebaseAuth.signOut();
        throw const LogInWithEmailAndPasswordFailure(
            'Current user is null after authentication.');
      }

      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      if (e is LogInWithEmailAndPasswordFailure) {
        rethrow;
      } else {
        throw const LogInWithEmailAndPasswordFailure();
      }
    }
  }

  @override
  Future<UserModel> authenticateGoogleSignin() async {
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
          'isInitiate': false
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
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataById(
      String userId) async {
    try {
      final result =
          await _firestore.collection('UserAccount').doc(userId).get();
      if (result.exists) {
        final updateFirestore = UserAccountModel.fromFirestore(result);
        await _firestore
            .collection('UserAccount')
            .doc(updateFirestore.userId)
            .set(updateFirestore.toFirestore());
      }
      return result;
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (_) {
      throw const FireBaseCatchFailure();
    }
  }

  @override
  Future<UserAccountModel> getUserAccountById(String uid) async {
    try {
      final result = await _firestore.collection('UserAccount').doc(uid).get();
      return result.exists
          ? UserAccountModel.fromFirestore(result)
          : UserAccountModel.empty;
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

  @override
  Future<String> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'request has sent to email';
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthInitializeFailure.fromCode(e.code);
    } catch (_) {
      throw const AuthInitializeFailure();
    }
  }
}



  // @override
  // Future<String> signUpEmailAndPassword(
  //   RegisterAuthentication credential,
  // ) async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: credential.email, password: credential.password);

  //     final user = _firebaseAuth.currentUser;
  //     if (user != null) {
  //       if (credential.isWeb != null && credential.isWeb == true) {
  //         // Web
  //         if (credential.avatarWeb != null) {
  //           // Convert Uint8List to Blob
  //           final blob = html.Blob([credential.avatarWeb!]);

  //           // Upload to Firebase Storage
  //           var snapshot = await _firebaseStorage
  //               .ref()
  //               .child('user_image/user_profile/${user.uid}')
  //               .putBlob(blob);

  //           // Get download URL
  //           String downloadUrl = await snapshot.ref.getDownloadURL();

  //           // Update user photo URL
  //           await user.updateProfile(
  //               displayName: credential.name, photoURL: downloadUrl);
  //           //await user.updatePhotoURL(downloadUrl);

  //           // Prepare user account data
  //           final userAccountData = {
  //             'email': credential.email,
  //             'name': credential.name,
  //             'photo': downloadUrl,
  //             'mitra_id': credential.mitraId,
  //             'isInitiate': true,
  //           };

  //           // Save to Firestore
  //           await _firestore
  //               .collection('UserAccount')
  //               .doc(user.uid)
  //               .set(userAccountData);
  //         } else {
  //           // Avatar web is null
  //           final userAccountData = {
  //             'email': credential.email,
  //             'name': credential.name,
  //             'photo': '',
  //             'mitra_id': credential.mitraId,
  //             'isInitiate': true,
  //           };
  //           await _firestore
  //               .collection('UserAccount')
  //               .doc(user.uid)
  //               .set(userAccountData);
  //         }
  //       } else {
  //         // Mobile

  //         if (credential.avatar != null) {
  //           var snapshot = await _firebaseStorage
  //               .ref()
  //               .child('user_image/user_profile/${user.uid}')
  //               .putFile(credential.avatar!);

  //           String downloadUrl = await snapshot.ref.getDownloadURL();
  //           await user.updateProfile(
  //               displayName: credential.name, photoURL: downloadUrl);
  //           //await user.updatePhotoURL(downloadUrl);

  //           final userAccountData = {
  //             'email': credential.email,
  //             'name': credential.name,
  //             'photo': downloadUrl,
  //             'mitra_id': credential.mitraId,
  //             'isInitiate': true,
  //           };

  //           await _firestore
  //               .collection('UserAccount')
  //               .doc(user.uid)
  //               .set(userAccountData);
  //         } else {
  //           final userAccountData = {
  //             'email': credential.email,
  //             'name': credential.name,
  //             'photo': '',
  //             'mitra_id': credential.mitraId,
  //             'isInitiate': true,
  //           };
  //           await user.updateProfile(displayName: credential.name);
  //           await _firestore
  //               .collection('UserAccount')
  //               .doc(user.uid)
  //               .set(userAccountData);
  //         }
  //       }
  //       await _firebaseAuth.signOut();
  //     } else {
  //       // User is null after registration
  //       debugPrint('User is null after registration');
  //     }
  //     return 'User has been registered';
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     debugPrint('FirebaseAuthException: ${e.code}');
  //     throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
  //   } catch (error) {
  //     debugPrint('Exception: $error');
  //     throw const SignUpWithEmailAndPasswordFailure();
  //   }
  // }


  //////////////////////////////////////////////////////////
  // WITHOUT VERIFYING EMAIL
   //////////////////////////////////////////////////////////
  // @override
  // Future<String> signUpEmailAndPassword(
  //   RegisterAuthentication credential,
  // ) async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: credential.email, password: credential.password);

  //     final user = _firebaseAuth.currentUser;
  //     if (user == null) {
  //       debugPrint('User is null after registration');
  //       return 'User registration failed';
  //     }

  //     String downloadUrl = '';
  //     if (credential.isWeb == true && credential.avatarWeb != null) {
  //       final blob = html.Blob([credential.avatarWeb!]);
  //       var snapshot = await _firebaseStorage
  //           .ref()
  //           .child('user_image/user_profile/${user.uid}')
  //           .putBlob(blob);
  //       downloadUrl = await snapshot.ref.getDownloadURL();
  //     } else if (credential.avatar != null) {
  //       var snapshot = await _firebaseStorage
  //           .ref()
  //           .child('user_image/user_profile/${user.uid}')
  //           .putFile(credential.avatar!);
  //       downloadUrl = await snapshot.ref.getDownloadURL();
  //     }

  //     await user.updateProfile(
  //       displayName: credential.name,
  //       photoURL: downloadUrl.isNotEmpty ? downloadUrl : null,
  //     );

  //     final userAccountData = {
  //       'email': credential.email,
  //       'name': credential.name,
  //       'photo': downloadUrl,
  //       'mitra_id': credential.mitraId,
  //       'isInitiate': true,
  //     };

  //     await _firestore
  //         .collection('UserAccount')
  //         .doc(user.uid)
  //         .set(userAccountData);

  //     await _firebaseAuth.signOut();
  //     return 'User has been registered';
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     debugPrint('FirebaseAuthException: ${e.code}');
  //     throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
  //   } catch (error) {
  //     debugPrint('Exception: $error');
  //     throw const SignUpWithEmailAndPasswordFailure();
  //   }
  // }

  //  @override
  // Future<User> loginEmailAndPassword(String email, String password) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     final result = _firebaseAuth.currentUser;

  //     if (result != null) {
  //       return result;
  //     } else {
  //       throw const LogInWithEmailAndPasswordFailure(
  //           'Current user is null after authentication.');
  //     }
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
  //   } catch (_) {
  //     throw const LogInWithEmailAndPasswordFailure();
  //   }
  // }