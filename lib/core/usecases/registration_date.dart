import 'package:formz/formz.dart';

enum RegistrationDateValidationError { invalid }

class RegistrationDate
    extends FormzInput<String, RegistrationDateValidationError> {
  const RegistrationDate.pure() : super.pure('');

  const RegistrationDate.dirty([super.value = '']) : super.dirty();

  static final RegExp _registrationDateRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}$',
  );

  @override
  RegistrationDateValidationError? validator(String? value) {
    return _registrationDateRegExp.hasMatch(value ?? '')
        ? null
        : RegistrationDateValidationError.invalid;
  }
}
