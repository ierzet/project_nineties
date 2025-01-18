import 'package:formz/formz.dart';

enum GenderValidationError { invalid }

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure() : super.pure('');

  const Gender.dirty([super.value = '']) : super.dirty();

  // static final RegExp _genderRegExp = RegExp(r"^[LP]$");
  static final RegExp _genderRegExp = RegExp(r'^(Female|Male|Other)$');

  @override
  GenderValidationError? validator(String? value) {
    return _genderRegExp.hasMatch(value ?? '')
        ? null
        : GenderValidationError.invalid;
  }
}

// Explanation of the regex pattern:
// ^ asserts the start of the string.
// [LP] matches either "L" or "P".
// $ asserts the end of the string.
