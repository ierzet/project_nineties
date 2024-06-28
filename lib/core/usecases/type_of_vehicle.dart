import 'package:formz/formz.dart';

enum TypeOfVehicleValidationError { invalid }

class TypeOfVehicle extends FormzInput<String, TypeOfVehicleValidationError> {
  const TypeOfVehicle.pure() : super.pure('');

  const TypeOfVehicle.dirty([super.value = '']) : super.dirty();

  static final RegExp _typeOfVehicleRegExp = RegExp(r"^[A-Za-z\-\'\s]+$");

  @override
  TypeOfVehicleValidationError? validator(String? value) {
    return _typeOfVehicleRegExp.hasMatch(value ?? '')
        ? null
        : TypeOfVehicleValidationError.invalid;
  }
}
