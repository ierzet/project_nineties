import 'package:formz/formz.dart';

enum DurationOfMemberValidationError { invalid }

class DurationOfMember
    extends FormzInput<String, DurationOfMemberValidationError> {
  const DurationOfMember.pure() : super.pure('');

  const DurationOfMember.dirty([super.value = '']) : super.dirty();

  static final RegExp _durationOfMemberRegExp = RegExp(
    r'^(1|2|3|4|5|6|7|8|9|10|11|12)$',
  );

  @override
  DurationOfMemberValidationError? validator(String? value) {
    return _durationOfMemberRegExp.hasMatch(value ?? '')
        ? null
        : DurationOfMemberValidationError.invalid;
  }
}

// Explanation of the regex pattern:
// ^ asserts the start of the string.
// (1|2|3|4|5|6|7|8|9|10|11|12) matches any single-digit number from '1' to '12'.
// $ asserts the end of the string.