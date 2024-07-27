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
import 'package:project_nineties/features/authentication/domain/usecases/authentication_params.dart';
import 'package:universal_html/html.dart' as html;

abstract class AuthenticationRemoteDataSource {
  Future signUpEmailAndPassword(AuthenticationParams params);
  Future uploadFileImageAndUpdateProfile(AuthenticationParams params);
  Future<User> authenticateEmailAndPassword(AuthenticationParams params);
  Future<User> authenticateGoogleSignin();
  Future<User> authenticateFacebookSignin();
  Future<UserAccountModel> initiateUserAccountFireStore({
    required bool isInitiate,
  });
  Future<UserAccountModel> initiateUserAccountFalseFireStore({
    required UserAccountModel userAccount,
  });
  Future<DocumentSnapshot<Map<String, dynamic>>> getDataById(String userId);
  Future<UserAccountModel> getUserAccountById(String uid);
  Future<String> onLogOut();
  Future<String> resetPassword(String email);
  Future sendEmailNotification();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  //final GoogleSignIn? _googleSignIn;

  AuthenticationRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firestore,
    this._firebaseStorage,
    // this._googleSignIn,
  );

  @override
  Future signUpEmailAndPassword(AuthenticationParams params) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: params.email, password: params.password);
    } on FirebaseAuthException catch (e) {
      await _firebaseAuth.signOut();
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
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

  @override
  Future uploadFileImageAndUpdateProfile(AuthenticationParams params) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return 'User registration failed';
      }
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
      await user.updateProfile(
        displayName: params.name,
        photoURL: downloadUrl.isNotEmpty ? downloadUrl : null,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
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

  @override
  Future<String> sendEmailNotification() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return 'User registration failed';
    }
    await user.sendEmailVerification();

    await _firebaseAuth.signOut();
    // return 'User has been registered. Please verify your email address.';
    return 'Your user has been send appproval request. Please verify your email address and wait until admin approval your request';
  }

  @override
  Future<User> authenticateEmailAndPassword(AuthenticationParams params) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: params.email, password: params.password);
      final currentUser = _firebaseAuth.currentUser;

      //menggunakan verifikasi email
      if (currentUser == null || !currentUser.emailVerified) {
        await _firebaseAuth.signOut();
        throw LogInWithEmailAndPasswordFailure(currentUser == null
            ? 'Current user is null after authentication.'
            : 'Please verify your email address to log in.');
      }
      //tanpa verifikasi email
      // if (currentUser == null) {
      //   await _firebaseAuth.signOut();
      //   throw const LogInWithEmailAndPasswordFailure(
      //       'Current user is null after authentication.');
      // }

      return currentUser;
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
  Future<User> authenticateGoogleSignin() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        // googleProvider.setCustomParameters({'login_hint': ''});
        googleProvider
            .setCustomParameters({'login_hint': 'example@example.com'});

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);
        final currentUser = userCredential.user;

        if (currentUser != null) {
          return currentUser;
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
          return currentUser;
        } else {
          throw const LogInWithGoogleFailure(
              'Current user is null after authentication.');
        }
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      if (e is LogInWithGoogleFailure) {
        await _firebaseAuth.signOut();
        rethrow;
      } else {
        await _firebaseAuth.signOut();
        throw const LogInWithGoogleFailure();
      }
    }
  }

  @override
  Future<User> authenticateFacebookSignin() async {
    try {
      if (kIsWeb) {
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();
        facebookProvider.addScope('email');
        facebookProvider.setCustomParameters({'display': 'popup'});

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(facebookProvider);
        final currentUser = userCredential.user;

        if (currentUser != null) {
          return currentUser;
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
            return currentUser;
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
    } catch (e) {
      if (e is LogInWithGoogleFailure) {
        await _firebaseAuth.signOut();
        rethrow;
      } else {
        await _firebaseAuth.signOut();
        throw const LogInWithGoogleFailure();
      }
    }
  }

  @override
  Future<UserAccountModel> initiateUserAccountFireStore({
    required bool isInitiate,
  }) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        final userAccount = UserAccountModel.fromFirebaseUser(currentUser);

        await _firestore
            .collection('user_account')
            .doc(userAccount.user.id)
            .set(userAccount.initiateUserAccountToFirestore(
                isInitiate, currentUser.uid));

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
  Future<UserAccountModel> initiateUserAccountFalseFireStore({
    required UserAccountModel userAccount,
  }) async {
    try {
      await _firestore
          .collection('user_account')
          .doc(userAccount.user.id)
          .set(userAccount.initiateUserAccountFalseFireStore());
      return userAccount;
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
          await _firestore.collection('user_account').doc(userId).get();
      return result;
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        await _firebaseAuth.signOut();
        rethrow;
      } else {
        await _firebaseAuth.signOut();
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<UserAccountModel> getUserAccountById(String uid) async {
    try {
      final result = await _firestore.collection('user_account').doc(uid).get();
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
      if (!kIsWeb) {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
        await googleSignIn.disconnect();
      }

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
