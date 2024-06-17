import 'package:equatable/equatable.dart';

class LoginAuthentication extends Equatable {
  const LoginAuthentication({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
