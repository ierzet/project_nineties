import 'package:formz/formz.dart';

enum NoVehicleValidationError { invalid }

class NoVehicle extends FormzInput<String, NoVehicleValidationError> {
  const NoVehicle.pure() : super.pure('');

  const NoVehicle.dirty([super.value = '']) : super.dirty();

  static final RegExp _noVehicleRegExp = RegExp(
    r'^[A-Z]{1,3}\s\d{1,4}\s[A-Z]{1,2}$',
  );

  @override
  NoVehicleValidationError? validator(String? value) {
    return _noVehicleRegExp.hasMatch(value ?? '')
        ? null
        : NoVehicleValidationError.invalid;
  }
}

// Explanation of the regex pattern:
// ^ asserts the start of the string.
// [A-Z]{1,3} matches one to three uppercase letters, which represent the vehicle's region code.
// \s matches a single whitespace character (e.g., space or tab).
// \d{1,4} matches one to four digits, representing the vehicle's number.
// \s matches another whitespace character.
// [A-Z]{1,2} matches one or two uppercase letters, representing the vehicle's category or type.