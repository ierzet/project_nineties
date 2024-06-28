import 'package:formz/formz.dart';

enum TypeOfMemberValidationError { invalid }

class TypeOfMember extends FormzInput<String, TypeOfMemberValidationError> {
  const TypeOfMember.pure() : super.pure('');

  const TypeOfMember.dirty([super.value = '']) : super.dirty();

  static final RegExp _typeOfMemberRegExp = RegExp(
    r'^(basic|gold|platinum)$',
  );
  @override
  TypeOfMemberValidationError? validator(String? value) {
    return _typeOfMemberRegExp.hasMatch(value ?? '')
        ? null
        : TypeOfMemberValidationError.invalid;
  }
}

// Explanation of the regex pattern:
// ^ asserts the start of the string.
// (basic|gold|platinum) matches either 'basic,' 'gold,' or 'platinum.'
// $ asserts the end of the string.