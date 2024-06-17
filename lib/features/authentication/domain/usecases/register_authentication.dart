import 'package:equatable/equatable.dart';

class RegisterAuthentication extends Equatable {
  final String email;
  final String name;
  final String password;
  final String confirmedPassword;
  final String photo;
  final String mitraId;

  const RegisterAuthentication(
      {required this.email,
      required this.name,
      required this.password,
      required this.confirmedPassword,
      required this.photo,
      required this.mitraId});
  @override
  List<Object> get props => [email, name, password, photo, mitraId];
}
