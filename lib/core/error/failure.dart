import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class RegisteringPartnerFailure extends Failure {
  const RegisteringPartnerFailure(super.message);
}

class AddToCartFailure extends Failure {
  const AddToCartFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class SharedPreferenceFailure extends Failure {
  const SharedPreferenceFailure(super.message);
}

class LogInWithEmailAndPasswordFailure extends Failure {
  // ignore: use_super_parameters
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]) : super(message);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'invalid-login-credentials':
        return const LogInWithEmailAndPasswordFailure(
          'User is not found, please create an account.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );

      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  // ignore: overridden_fields
  final String message;
}

class SignUpWithEmailAndPasswordFailure extends Failure {
  /// {@macro sign_up_with_email_and_password_failure}
  // ignore: use_super_parameters
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  @override
  // ignore: overridden_fields
  final String message;
}

class LogInWithGoogleFailure extends Failure {
  /// {@macro log_in_with_google_failure}
  // ignore: use_super_parameters
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  @override
  // ignore: overridden_fields
  final String message;
}

class AuthInitializeFailure extends Failure {
  /// {@macro log_in_with_google_failure}
  // ignore: use_super_parameters
  const AuthInitializeFailure([
    this.message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory AuthInitializeFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const AuthInitializeFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const AuthInitializeFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const AuthInitializeFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const AuthInitializeFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const AuthInitializeFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const AuthInitializeFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const AuthInitializeFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const AuthInitializeFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const AuthInitializeFailure();
    }
  }

  /// The associated error message.
  @override
  // ignore: overridden_fields
  final String message;
}

class FireBaseCatchFailure extends Failure {
  // ignore: use_super_parameters
  const FireBaseCatchFailure([
    this.message = 'An unknown exception occurred.',
  ]) : super(message);

  factory FireBaseCatchFailure.fromCode(String code) {
    switch (code) {
      default:
        return const FireBaseCatchFailure();
    }
  }

  @override
  // ignore: overridden_fields
  final String message;
}

class FirebaseStorageFailure extends Failure {
  // ignore: use_super_parameters
  const FirebaseStorageFailure([
    this.message = 'An unknown exception occurred.',
  ]) : super(message);

  factory FirebaseStorageFailure.fromCode(String code) {
    switch (code) {
      case 'storage/unknown':
        return const FirebaseStorageFailure('An unknown error occurred.');
      case 'storage/object-not-found':
        return const FirebaseStorageFailure(
            'No object exists at the desired reference.');
      case 'storage/bucket-not-found':
        return const FirebaseStorageFailure(
            'No bucket is configured for Cloud Storage.');
      case 'storage/project-not-found':
        return const FirebaseStorageFailure(
            'No project is configured for Cloud Storage.');
      case 'storage/quota-exceeded':
        return const FirebaseStorageFailure(
            'Quota on your Cloud Storage bucket has been exceeded. If you\'re on the no-cost tier, upgrade to a paid plan. If you\'re on a paid plan, reach out to Firebase support.');
      case 'storage/unauthenticated':
        return const FirebaseStorageFailure(
            'User is unauthenticated, please authenticate and try again.');
      case 'storage/unauthorized':
        return const FirebaseStorageFailure(
            'User is not authorized to perform the desired action, check your security rules to ensure they are correct.');
      case 'storage/retry-limit-exceeded':
        return const FirebaseStorageFailure(
            'The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded. Try uploading again.');
      case 'storage/invalid-checksum':
        return const FirebaseStorageFailure(
            'File on the client does not match the checksum of the file received by the server. Try uploading again.');
      case 'storage/canceled':
        return const FirebaseStorageFailure('User canceled the operation.');
      case 'storage/invalid-event-name':
        return const FirebaseStorageFailure(
            'Invalid event name provided. Must be one of [running, progress, pause].');
      case 'storage/invalid-url':
        return const FirebaseStorageFailure(
            'Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>');
      case 'storage/invalid-argument':
        return const FirebaseStorageFailure(
            'The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.');
      case 'storage/no-default-bucket':
        return const FirebaseStorageFailure(
            'No bucket has been set in your config\'s storageBucket property.');
      case 'storage/cannot-slice-blob':
        return const FirebaseStorageFailure(
            'Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn\'t changed.');
      case 'storage/server-file-wrong-size':
        return const FirebaseStorageFailure(
            'File on the client does not match the size of the file received by the server. Try uploading again.');
      default:
        return const FirebaseStorageFailure('An unknown error occurred.');
    }
  }

  @override
  // ignore: overridden_fields
  final String message;
}
