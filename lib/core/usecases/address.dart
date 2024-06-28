import 'package:formz/formz.dart';

enum AddressValidationError { invalid }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');

  const Address.dirty([super.value = '']) : super.dirty();

  static final RegExp _addressRegExp = RegExp(r'^\S.*$');
  @override
  AddressValidationError? validator(String? value) {
    return _addressRegExp.hasMatch(value ?? '')
        ? null
        : AddressValidationError.invalid;
  }
}

// ^ asserts the start of the string.
// [A-Za-z\-\'\s] defines a character set that matches uppercase letters (A-Z), lowercase letters (a-z), hyphens (-), apostrophes ('), and spaces (\s).
// + allows one or more characters from the character set.
// $ asserts the end of the string.