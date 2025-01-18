import 'package:formz/formz.dart';

enum ExpiredDateValidationError { invalid }

class ExpiredDate extends FormzInput<String, ExpiredDateValidationError> {
  const ExpiredDate.pure() : super.pure('');

  const ExpiredDate.dirty([super.value = '']) : super.dirty();

  static final RegExp _joinDateRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}$',
  );

  @override
  ExpiredDateValidationError? validator(String? value) {
    return _joinDateRegExp.hasMatch(value ?? '')
        ? null
        : ExpiredDateValidationError.invalid;
  }
}
