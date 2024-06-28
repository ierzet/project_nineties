import 'package:formz/formz.dart';

// enum NameValidationError { invalid }

// class Name extends FormzInput<String, NameValidationError> {
//   const Name.pure() : super.pure('');

//   const Name.dirty([super.value = '']) : super.dirty();

//   static final RegExp _nameRegExp = RegExp(r"^[A-Za-z\-\'\s]+$");

//   @override
//   NameValidationError? validator(String? value) {
//     return _nameRegExp.hasMatch(value ?? '')
//         ? null
//         : NameValidationError.invalid;
//   }
// }

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(r"^[A-Za-z\-\'\s]+$");

  @override
  NameValidationError? validator(String? value) {
    return value != null && _nameRegExp.hasMatch(value.trim())
        ? null
        : NameValidationError.invalid;
  }
}


// ^ asserts the start of the string.
// [A-Za-z\-\'\s] defines a character set that matches uppercase letters (A-Z), lowercase letters (a-z), hyphens (-), apostrophes ('), and spaces (\s).
// + allows one or more characters from the character set.
// $ asserts the end of the string.