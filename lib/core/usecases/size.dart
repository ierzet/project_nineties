import 'package:formz/formz.dart';

enum SizeOfVehicleValidationError { invalid }

class SizeOfVehicle extends FormzInput<String, SizeOfVehicleValidationError> {
  const SizeOfVehicle.pure() : super.pure('');

  const SizeOfVehicle.dirty([super.value = '']) : super.dirty();

  static final RegExp _sizeOfVehicleRegExp = RegExp(r"^[A-Za-z\-\'\s]+$");

  @override
  SizeOfVehicleValidationError? validator(String? value) {
    return _sizeOfVehicleRegExp.hasMatch(value ?? '')
        ? null
        : SizeOfVehicleValidationError.invalid;
  }
}
