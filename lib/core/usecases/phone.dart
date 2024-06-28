import 'package:formz/formz.dart';

enum PhoneValidationError { invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneRegExp = RegExp(r"^(?:\+62|0)[0-9]{9,15}$");

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}

// Explanation of the regex pattern:
// ^ asserts the start of the string.
// (?:\+62|0) allows for two possibilities: the number can start with either "+62" (the international dialing code for Indonesia) or "0" (the local prefix).
// [0-9]{9,15} matches between 9 to 15 consecutive digits. This accounts for the variable length of Indonesian phone numbers.