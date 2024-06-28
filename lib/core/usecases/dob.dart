import 'package:formz/formz.dart';

enum DOBValidationError { invalid }

class DOB extends FormzInput<String, DOBValidationError> {
  const DOB.pure() : super.pure('');

  const DOB.dirty([super.value = '']) : super.dirty();

  static final RegExp _dOBRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}$',
  );

  @override
  DOBValidationError? validator(String? value) {
    return _dOBRegExp.hasMatch(value ?? '') ? null : DOBValidationError.invalid;
  }
}

// Explanation of the regex pattern:

// ^ asserts the start of the string.
// \d{4} matches exactly four digits for the year.
// - matches the hyphen separator between year, month, and day.
// \d{2} matches exactly two digits for the month.
// - matches another hyphen separator.
// \d{2} matches exactly two digits for the day.
// (space) matches the space between the date and time.
// \d{2} matches exactly two digits for the hour.
// : matches the colon separator between hours and minutes.
// \d{2} matches exactly two digits for the minutes.
// : matches another colon separator.
// \d{2} matches exactly two digits for the seconds.
// \. matches the period before milliseconds.
// \d{3} matches exactly three digits for the milliseconds.
// $ asserts the end of the string.