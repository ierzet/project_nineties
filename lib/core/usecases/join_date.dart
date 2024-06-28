import 'package:formz/formz.dart';

enum JoinDateValidationError { invalid }

class JoinDate extends FormzInput<String, JoinDateValidationError> {
  const JoinDate.pure() : super.pure('');

  const JoinDate.dirty([super.value = '']) : super.dirty();

  static final RegExp _joinDateRegExp = RegExp(
    r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}$',
  );

  @override
  JoinDateValidationError? validator(String? value) {
    return _joinDateRegExp.hasMatch(value ?? '')
        ? null
        : JoinDateValidationError.invalid;
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