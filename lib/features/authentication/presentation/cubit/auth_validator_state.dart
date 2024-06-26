part of 'auth_validator_cubit.dart';

class AuthValidatorCubitState extends Equatable {
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool nameIsValid;
  final bool confirmedPasswordIsValid;
  final String email;
  final String password;
  final String name;
  final String confirmedPassword;
  final io.File? avatarFile;
  final File? avatarFileWeb;
  final bool? isWeb;
 // Add this property

  const AuthValidatorCubitState(
      {required this.emailIsValid,
      required this.passwordIsValid,
      required this.nameIsValid,
      required this.confirmedPasswordIsValid,
      required this.email,
      required this.password,
      required this.name,
      required this.confirmedPassword,
      this.avatarFile,
      this.avatarFileWeb,
      this.isWeb // Include in constructor
      });

  static const empty = AuthValidatorCubitState(
    emailIsValid: false,
    passwordIsValid: false,
    nameIsValid: false,
    confirmedPasswordIsValid: false,
    email: '',
    password: '',
    name: '',
    confirmedPassword: '',
    avatarFile: null,
    avatarFileWeb: null,
    isWeb: null,
  );

  bool get isEmpty => this == AuthValidatorCubitState.empty;
  bool get isNotEmpty => this != AuthValidatorCubitState.empty;

  @override
  List<Object?> get props => [
        emailIsValid,
        passwordIsValid,
        nameIsValid,
        confirmedPasswordIsValid,
        email,
        password,
        name,
        confirmedPassword,
        avatarFile,
        avatarFileWeb,
        isWeb,
      ];
}
