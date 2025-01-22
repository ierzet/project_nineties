import 'package:formz/formz.dart';

enum NoVehicleValidationError { invalid }

class NoVehicle extends FormzInput<String, NoVehicleValidationError> {
  const NoVehicle.pure() : super.pure('');

  const NoVehicle.dirty([super.value = '']) : super.dirty();

  // General vehicle license plate pattern
  static final RegExp _generalPattern = RegExp(
    r'^([A-Z]{1,3})(\s|-)*([1-9][0-9]{0,3})(\s|-)*([A-Z]{0,3}|[1-9][0-9]{1,2})$',
    caseSensitive: false,
  );

  // Diplomatic vehicle license plate pattern
  static final RegExp _diplomaticPattern = RegExp(
    r'^([A-Z]{2})\s([1-9][0-9]{1,4})\s([1-9][0-9]{1,2})$',
    caseSensitive: false,
  );

  // Military and police vehicle license plate pattern
  static final RegExp _militaryPolicePattern = RegExp(
    r'^([0-9]{1,5})(\s|-)*([0-9]{2}|[IVX]{1,5})$',
    caseSensitive: false,
  );

  @override
  NoVehicleValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return NoVehicleValidationError.invalid;
    }

    String trimmedValue = value.trim().toUpperCase();

    if (_generalPattern.hasMatch(trimmedValue) ||
        _diplomaticPattern.hasMatch(trimmedValue) ||
        _militaryPolicePattern.hasMatch(trimmedValue)) {
      return null;
    }

    return NoVehicleValidationError.invalid;
  }
}  


// enum NoVehicleValidationError { invalid }

// class NoVehicle extends FormzInput<String, NoVehicleValidationError> {
//   const NoVehicle.pure() : super.pure('');

//   const NoVehicle.dirty([super.value = '']) : super.dirty();

//   static final RegExp _noVehicleRegExp = RegExp(
//     r'^[A-Z]{1,3}\s\d{1,4}\s[A-Z]{1,2}$',
//   );

//   @override
//   NoVehicleValidationError? validator(String? value) {
//     return _noVehicleRegExp.hasMatch(value ?? '')
//         ? null
//         : NoVehicleValidationError.invalid;
//   }
// }

// Explanation of the regex pattern:
// ^ asserts the start of the string.
// [A-Z]{1,3} matches one to three uppercase letters, which represent the vehicle's region code.
// \s matches a single whitespace character (e.g., space or tab).
// \d{1,4} matches one to four digits, representing the vehicle's number.
// \s matches another whitespace character.
// [A-Z]{1,2} matches one or two uppercase letters, representing the vehicle's category or type.