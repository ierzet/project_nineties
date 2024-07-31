// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDRQ3VLudEuN_hX8k2rhRtA63oIrWLd0_A',
    appId: '1:582028717733:web:cec1158a6491286e37a74c',
    messagingSenderId: '582028717733',
    projectId: 'project-nineties',
    authDomain: 'project-nineties.firebaseapp.com',
    storageBucket: 'project-nineties.appspot.com',
    measurementId: 'G-RPSCYLJB49',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYIonsSlLPyGtRvSgdBd6D4LAFaDVcUa4',
    appId: '1:582028717733:ios:f7e133a5c351b1f137a74c',
    messagingSenderId: '582028717733',
    projectId: 'project-nineties',
    storageBucket: 'project-nineties.appspot.com',
    iosClientId: '582028717733-3ae46ocbhjecckksh7j29vjfnm6746d0.apps.googleusercontent.com',
    iosBundleId: 'com.erzetsatari.developer.projectNineties',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqHuCu5Vg5P7on6y76-9uTjQRid6FywvU',
    appId: '1:582028717733:android:a9fdd5e6206f02e937a74c',
    messagingSenderId: '582028717733',
    projectId: 'project-nineties',
    storageBucket: 'project-nineties.appspot.com',
  );

}