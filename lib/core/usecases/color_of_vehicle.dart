import 'package:formz/formz.dart';

enum ColorOfVehicleValidationError { invalid }

class ColorOfVehicle extends FormzInput<String, ColorOfVehicleValidationError> {
  const ColorOfVehicle.pure() : super.pure('');

  const ColorOfVehicle.dirty([super.value = '']) : super.dirty();

  static final RegExp _colorOfVehicleRegExp = RegExp(r"^[A-Za-z\-\'\s]+$");

  @override
  ColorOfVehicleValidationError? validator(String? value) {
    return _colorOfVehicleRegExp.hasMatch(value ?? '')
        ? null
        : ColorOfVehicleValidationError.invalid;
  }
}
