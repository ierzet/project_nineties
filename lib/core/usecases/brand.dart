import 'package:formz/formz.dart';

enum BrandOfVehicleValidationError { invalid }

class BrandOfVehicle extends FormzInput<String, BrandOfVehicleValidationError> {
  const BrandOfVehicle.pure() : super.pure('');

  const BrandOfVehicle.dirty([super.value = '']) : super.dirty();

  static final RegExp _brandOfVehicleRegExp = RegExp(r"^[A-Za-z\-\'\s]+$");

  @override
  BrandOfVehicleValidationError? validator(String? value) {
    return _brandOfVehicleRegExp.hasMatch(value ?? '')
        ? null
        : BrandOfVehicleValidationError.invalid;
  }
}
