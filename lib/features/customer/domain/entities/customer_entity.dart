import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:project_nineties/core/usecases/color_of_vehicle.dart';
import 'package:project_nineties/core/usecases/dob.dart';
import 'package:project_nineties/core/usecases/gender.dart';
import 'package:project_nineties/core/usecases/join_date.dart';
import 'package:project_nineties/core/usecases/name.dart';
import 'package:project_nineties/core/usecases/no_vehicle.dart';
import 'package:project_nineties/core/usecases/phone.dart';
import 'package:project_nineties/core/usecases/type_of_member.dart';
import 'package:project_nineties/core/usecases/type_of_vehicle.dart';
import 'package:project_nineties/features/authentication/domain/usecases/email.dart';

class CustomerEntity extends Equatable {
  final String customerId;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhoneNumber;
  final String? customerGender;
  final DateTime? customerDateOfBirth;
  final String? customerNoVehicle;
  final String? customerTypeOfVehicle;
  final String? customerColorOfVehicle;
  final String? customerTypeOfMember;
  final bool? customerStatusMember;
  final DateTime? customerJoinDate;
  final DateTime? customerExpiredDate;
  final String? customerCreatedBy;
  final DateTime? customerCreatedDate;
  final String? customerUpdatedBy;
  final DateTime? customerUpdatedDate;
  final String? customerDeletedBy;
  final DateTime? customerDeletedDate;
  final bool? customerIsDeleted;

  const CustomerEntity({
    required this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerPhoneNumber,
    this.customerGender,
    this.customerDateOfBirth,
    this.customerNoVehicle,
    this.customerTypeOfVehicle,
    this.customerColorOfVehicle,
    this.customerTypeOfMember,
    this.customerStatusMember,
    this.customerJoinDate,
    this.customerExpiredDate,
    this.customerCreatedBy,
    this.customerCreatedDate,
    this.customerUpdatedBy,
    this.customerUpdatedDate,
    this.customerDeletedBy,
    this.customerDeletedDate,
    this.customerIsDeleted,
  });

  static final empty = CustomerEntity(
      customerId: '',
      customerJoinDate: DateTime(1970, 1, 1),
      customerDateOfBirth: DateTime(1970, 1, 1),
      customerExpiredDate: DateTime(1970, 1, 1));

  bool get isEmpty => this == CustomerEntity.empty;
  bool get isNotEmpty => this != CustomerEntity.empty;

  bool get isNameValid => Name.dirty(customerName ?? '').isValid;
  bool get isEmailValid => Email.dirty(customerEmail ?? '').isValid;
  bool get isPhoneValid => Phone.dirty(customerPhoneNumber ?? '').isValid;
  bool get isGenderValid => Gender.dirty(customerGender ?? '').isValid;
  bool get isDOBValid =>
      DOB.dirty(customerDateOfBirth?.toString() ?? '').isValid;
  bool get isNoVehicleValid => NoVehicle.dirty(customerNoVehicle ?? '').isValid;
  bool get isTypeOfVehicleValid =>
      TypeOfVehicle.dirty(customerTypeOfVehicle ?? '').isValid;
  bool get isColorOfVehicleValid =>
      ColorOfVehicle.dirty(customerColorOfVehicle ?? '').isValid;
  bool get isTypeOfMemberValid =>
      TypeOfMember.dirty(customerTypeOfMember ?? '').isValid;
  bool get isJoinDateValid =>
      JoinDate.dirty(customerJoinDate?.toString() ?? '').isValid;

  bool get isValid {
    final name = Name.dirty(customerName ?? '');
    final email = Email.dirty(customerEmail ?? '');
    final phone = Phone.dirty(customerPhoneNumber ?? '');
    //final gender = Gender.dirty(customerGender ?? '');
    //final dob = DOB.dirty(customerDateOfBirth.toString());
    final noVehicle = NoVehicle.dirty(customerNoVehicle ?? '');
    final typeOfVehicle = TypeOfVehicle.dirty(customerTypeOfVehicle ?? '');
    // final colorOfVehicle = ColorOfVehicle.dirty(customerColorOfVehicle ?? '');
    // final typeOfMember = TypeOfMember.dirty(customerTypeOfMember ?? '');
    //final durationOfMember = DurationOfMember.dirty(customerDuration??'');
    //final joinDate = JoinDate.dirty(customerJoinDate.toString());

    return Formz.validate([
      name,
      email,
      phone,
      // gender,
      // dob,
      noVehicle,
      typeOfVehicle,
      // colorOfVehicle,
      // typeOfMember,
      // durationOfMember,
      //joinDate,
    ]);
  }

  CustomerEntity copyWith({
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhoneNumber,
    String? customerGender,
    DateTime? customerDateOfBirth,
    String? customerNoVehicle,
    String? customerTypeOfVehicle,
    String? customerColorOfVehicle,
    String? customerTypeOfMember,
    bool? customerStatusMember,
    DateTime? customerJoinDate,
    DateTime? customerExpiredDate,
    String? customerCreatedBy,
    DateTime? customerCreatedDate,
    String? customerUpdatedBy,
    DateTime? customerUpdatedDate,
    String? customerDeletedBy,
    DateTime? customerDeletedDate,
    bool? customerIsDeleted,
  }) {
    return CustomerEntity(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      customerGender: customerGender ?? this.customerGender,
      customerDateOfBirth: customerDateOfBirth ?? this.customerDateOfBirth,
      customerNoVehicle: customerNoVehicle ?? this.customerNoVehicle,
      customerTypeOfVehicle:
          customerTypeOfVehicle ?? this.customerTypeOfVehicle,
      customerColorOfVehicle:
          customerColorOfVehicle ?? this.customerColorOfVehicle,
      customerTypeOfMember: customerTypeOfMember ?? this.customerTypeOfMember,
      customerStatusMember: customerStatusMember ?? this.customerStatusMember,
      customerJoinDate: customerJoinDate ?? this.customerJoinDate,
      customerExpiredDate: customerExpiredDate ?? this.customerExpiredDate,
      customerCreatedBy: customerCreatedBy ?? this.customerCreatedBy,
      customerCreatedDate: customerCreatedDate ?? this.customerCreatedDate,
      customerUpdatedBy: customerUpdatedBy ?? this.customerUpdatedBy,
      customerUpdatedDate: customerUpdatedDate ?? this.customerUpdatedDate,
      customerDeletedBy: customerDeletedBy ?? this.customerDeletedBy,
      customerDeletedDate: customerDeletedDate ?? this.customerDeletedDate,
      customerIsDeleted: customerIsDeleted ?? this.customerIsDeleted,
    );
  }

  @override
  List<Object?> get props => [
        customerId,
        customerName,
        customerEmail,
        customerPhoneNumber,
        customerGender,
        customerDateOfBirth,
        customerNoVehicle,
        customerTypeOfVehicle,
        customerColorOfVehicle,
        customerTypeOfMember,
        customerStatusMember,
        customerJoinDate,
        customerExpiredDate,
        customerCreatedBy,
        customerCreatedDate,
        customerUpdatedBy,
        customerUpdatedDate,
        customerDeletedBy,
        customerDeletedDate,
        customerIsDeleted,
      ];
}
