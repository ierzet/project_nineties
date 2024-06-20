import 'package:equatable/equatable.dart';

class LoginAuthentication extends Equatable {
  const LoginAuthentication({required this.email, required this.password});

  final String email;
  final String password;

  LoginAuthentication copyWith({String? email, String? password}) {
    return LoginAuthentication(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}
