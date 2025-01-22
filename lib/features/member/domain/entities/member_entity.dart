import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:project_nineties/core/usecases/address.dart';
import 'package:project_nineties/core/usecases/brand.dart';
import 'package:project_nineties/core/usecases/color_of_vehicle.dart';
import 'package:project_nineties/core/usecases/dob.dart';
import 'package:project_nineties/core/usecases/expired_date.dart';
import 'package:project_nineties/core/usecases/gender.dart';
import 'package:project_nineties/core/usecases/join_date.dart';
import 'package:project_nineties/core/usecases/name.dart';
import 'package:project_nineties/core/usecases/no_vehicle.dart';
import 'package:project_nineties/core/usecases/phone.dart';
import 'package:project_nineties/core/usecases/registration_date.dart';
import 'package:project_nineties/core/usecases/size.dart';
import 'package:project_nineties/core/usecases/type_of_member.dart';
import 'package:project_nineties/core/usecases/type_of_vehicle.dart';
import 'package:project_nineties/features/authentication/domain/usecases/email.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class MemberEntity extends Equatable {
  final String memberId;
  final String? memberName;
  final String? memberEmail;
  final String? memberPhoneNumber;
  final String? memberGender;
  final DateTime? memberDateOfBirth;
  final String? memberAddress;

  ///////////////////////////////////
  final String? memberPhotoOfVehicle;
  final int? memberYearOfVehicle;
  final String? memberNoVehicle;
  final String? memberTypeOfVehicle;
  final String? memberColorOfVehicle;
  final String? memberBrandOfVehicle;
  final String? memberSizeOfVehicle;

  ////////////////////////////////////
  final String? memberTypeOfMember;
  final bool? memberStatusMember;
  final DateTime? memberJoinDate;
  final DateTime? memberExpiredDate;
  final DateTime? memberRegistrationDate;
  final PartnerEntity? memberJoinPartner; // Assuming PartnerEntity is defined

  ///////////////////////////////////
  final String? memberCreatedBy;
  final DateTime? memberCreatedDate;
  final String? memberUpdatedBy;
  final DateTime? memberUpdatedDate;
  final String? memberDeletedBy;
  final DateTime? memberDeletedDate;
  final bool? memberIsDeleted;
  final Uint8List? memberPhotoOfVehicleFile;
  final DocumentSnapshot? docRef;
  final bool? isLegacy;

  const MemberEntity({
    required this.memberId,
    this.memberName,
    this.memberEmail,
    this.memberPhoneNumber,
    this.memberGender,
    this.memberDateOfBirth,
    this.memberAddress,
    this.memberPhotoOfVehicle,
    this.memberYearOfVehicle,
    this.memberNoVehicle,
    this.memberTypeOfVehicle,
    this.memberColorOfVehicle,
    this.memberBrandOfVehicle,
    this.memberSizeOfVehicle,
    this.memberTypeOfMember,
    this.memberStatusMember,
    this.memberJoinDate,
    this.memberExpiredDate,
    this.memberRegistrationDate,
    this.memberJoinPartner,
    this.memberCreatedBy,
    this.memberCreatedDate,
    this.memberUpdatedBy,
    this.memberUpdatedDate,
    this.memberDeletedBy,
    this.memberDeletedDate,
    this.memberIsDeleted,
    this.memberPhotoOfVehicleFile,
    this.docRef,
    this.isLegacy,
  });

  static final empty = MemberEntity(
    memberId: '',
    memberRegistrationDate: DateTime(1970, 1, 1),
    memberJoinDate: DateTime(1970, 1, 1),
    memberDateOfBirth: DateTime(1970, 1, 1),
    memberExpiredDate: DateTime(1970, 1, 1),
  );

  bool get isEmpty => this == MemberEntity.empty;
  bool get isNotEmpty => this != MemberEntity.empty;

  // Validation methods
  bool get isNameValid => Name.dirty(memberName ?? '').isValid;
  bool get isEmailValid => Email.dirty(memberEmail ?? '').isValid;
  bool get isPhoneValid => Phone.dirty(memberPhoneNumber ?? '').isValid;
  bool get isGenderValid => Gender.dirty(memberGender ?? '').isValid;
  bool get isDOBValid => DOB.dirty(memberDateOfBirth?.toString() ?? '').isValid;
  bool get isRegistrationDateValid =>
      RegistrationDate.dirty(memberRegistrationDate?.toString() ?? '').isValid;
  bool get isNoVehicleValid => NoVehicle.dirty(memberNoVehicle ?? '').isValid;
  bool get isAddressValid => Address.dirty(memberAddress ?? '').isValid;
  bool get isBrandOfVehicleValid =>
      BrandOfVehicle.dirty(memberBrandOfVehicle ?? '').isValid;
  bool get isSizeOfVehicleValid =>
      SizeOfVehicle.dirty(memberSizeOfVehicle ?? '').isValid;
  bool get isTypeOfVehicleValid =>
      TypeOfVehicle.dirty(memberTypeOfVehicle ?? '').isValid;
  bool get isColorOfVehicleValid =>
      ColorOfVehicle.dirty(memberColorOfVehicle ?? '').isValid;
  bool get isTypeOfMemberValid =>
      TypeOfMember.dirty(memberTypeOfMember ?? '').isValid;
  bool get isJoinDateValid =>
      JoinDate.dirty(memberJoinDate?.toString() ?? '').isValid;
  bool get isExpiredDateValid =>
      ExpiredDate.dirty(memberExpiredDate?.toString() ?? '').isValid;
  bool get isPhotoOfVehicleFileValid {
    // Example validation: Check if the file is not null and has a minimum size
    return memberPhotoOfVehicleFile != null &&
        memberPhotoOfVehicleFile!.isNotEmpty;
  }

  bool get isYearOfVehicleValid {
    // Check if memberJoinPartner is not null and has a valid partnerId
    return memberYearOfVehicle != null && memberYearOfVehicle! > 0;
  }

  bool get isJoinPartnerValid {
    // Check if memberJoinPartner is not null and has a valid partnerId
    return memberJoinPartner != null && memberJoinPartner!.partnerId.isNotEmpty;
  }

// Method to validate all fields and return errors
  Map<String, String> validateFields(String type) {
    final errors = <String, String>{};

    if (!isNameValid) {
      errors['name'] = 'Invalid name';
    }
    if (!isEmailValid) {
      errors['email'] = 'Invalid email';
    }
    if (!isPhoneValid) {
      errors['phone'] = 'Invalid phone number';
    }
    if (!isGenderValid || memberGender == "No Data") {
      errors['gender'] = 'Invalid gender';
    }
    // if (!isDOBValid) {
    //   errors['dob'] = 'Invalid date of birth';
    // }
    // if (!isRegistrationDateValid) {
    //   errors['registrationDate'] = 'Invalid registration date';
    // }
    if (!isNoVehicleValid) {
      errors['noVehicle'] = 'Invalid vehicle number';
    }
    if (!isAddressValid) {
      errors['address'] = 'Invalid address';
    }
    if (!isTypeOfVehicleValid || memberTypeOfVehicle == "No Data") {
      errors['typeOfVehicle'] = 'Invalid vehicle type';
    }
    if (!isColorOfVehicleValid) {
      errors['colorOfVehicle'] = 'Invalid vehicle color';
    }

    if (!isTypeOfMemberValid || memberTypeOfMember == "No Data") {
      errors['typeOfMember'] = 'Invalid member type';
    }
    if (!isBrandOfVehicleValid || memberBrandOfVehicle == "No Data") {
      errors['memberBrand'] = 'Invalid brand type';
    }

    if (!isSizeOfVehicleValid || memberSizeOfVehicle == "No Data") {
      errors['sizeOfVehicle'] = 'Invalid vehicle size';
    }
    // if (!isJoinDateValid) {
    //   errors['joinDate'] = 'Invalid join date';
    // }
    // if (!isExpiredDateValid) {
    //   errors['expiredDate'] = 'Invalid expired date';
    // }
    if (!isPhotoOfVehicleFileValid && type == 'register') {
      errors['photoOfVehicleFile'] = 'Invalid vehicle photo file';
    }
    if (!isJoinPartnerValid) {
      errors['joinPartner'] = 'Invalid Join Partner';
    }

    if (!isYearOfVehicleValid) {
      errors['yearOfVehicle'] = 'Invalid Year of Vehicle';
    }
    return errors;
  }

  bool get isValidRegister {
    final errors = validateFields('register');
    return errors.isEmpty;
  }

  bool get isValidUpdate {
    final errors = validateFields('update');
    return errors.isEmpty;
  }

  bool get isValidExtend {
    final errors = validateFields('extend');
    return errors.isEmpty;
  }
  // bool get isValid {
  //   final name = Name.dirty(memberName ?? '');
  //   final email = Email.dirty(memberEmail ?? '');
  //   final phone = Phone.dirty(memberPhoneNumber ?? '');
  //   final noVehicle = NoVehicle.dirty(memberNoVehicle ?? '');
  //  // final typeOfVehicle = TypeOfVehicle.dirty(memberTypeOfVehicle ?? '');

  //   return Formz.validate([
  //     name,
  //     email,
  //     phone,
  //     noVehicle,
  //     //typeOfVehicle,
  //   ]);
  // }

  MemberEntity copyWith({
    String? memberId,
    String? memberName,
    String? memberEmail,
    String? memberPhoneNumber,
    String? memberGender,
    DateTime? memberDateOfBirth,
    String? memberAddress,
    String? memberPhotoOfVehicle,
    int? memberYearOfVehicle,
    String? memberNoVehicle,
    String? memberTypeOfVehicle,
    String? memberColorOfVehicle,
    String? memberBrandOfVehicle,
    String? memberSizeOfVehicle,
    String? memberTypeOfMember,
    bool? memberStatusMember,
    DateTime? memberJoinDate,
    DateTime? memberExpiredDate,
    DateTime? memberRegistrationDate,
    PartnerEntity? memberJoinPartner,
    String? memberCreatedBy,
    DateTime? memberCreatedDate,
    String? memberUpdatedBy,
    DateTime? memberUpdatedDate,
    String? memberDeletedBy,
    DateTime? memberDeletedDate,
    bool? memberIsDeleted,
    Uint8List? memberPhotoOfVehicleFile,
    DocumentSnapshot? docRef,
    bool? isLegacy,
  }) {
    return MemberEntity(
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      memberEmail: memberEmail ?? this.memberEmail,
      memberPhoneNumber: memberPhoneNumber ?? this.memberPhoneNumber,
      memberGender: memberGender ?? this.memberGender,
      memberDateOfBirth: memberDateOfBirth ?? this.memberDateOfBirth,
      memberAddress: memberAddress ?? this.memberAddress,
      memberPhotoOfVehicle: memberPhotoOfVehicle ?? this.memberPhotoOfVehicle,
      memberYearOfVehicle: memberYearOfVehicle ?? this.memberYearOfVehicle,
      memberNoVehicle: memberNoVehicle ?? this.memberNoVehicle,
      memberTypeOfVehicle: memberTypeOfVehicle ?? this.memberTypeOfVehicle,
      memberColorOfVehicle: memberColorOfVehicle ?? this.memberColorOfVehicle,
      memberBrandOfVehicle: memberBrandOfVehicle ?? this.memberBrandOfVehicle,
      memberSizeOfVehicle: memberSizeOfVehicle ?? this.memberSizeOfVehicle,
      memberTypeOfMember: memberTypeOfMember ?? this.memberTypeOfMember,
      memberStatusMember: memberStatusMember ?? this.memberStatusMember,
      memberJoinDate: memberJoinDate ?? this.memberJoinDate,
      memberExpiredDate: memberExpiredDate ?? this.memberExpiredDate,
      memberRegistrationDate:
          memberRegistrationDate ?? this.memberRegistrationDate,
      memberJoinPartner: memberJoinPartner ?? this.memberJoinPartner,
      memberCreatedBy: memberCreatedBy ?? this.memberCreatedBy,
      memberCreatedDate: memberCreatedDate ?? this.memberCreatedDate,
      memberUpdatedBy: memberUpdatedBy ?? this.memberUpdatedBy,
      memberUpdatedDate: memberUpdatedDate ?? this.memberUpdatedDate,
      memberDeletedBy: memberDeletedBy ?? this.memberDeletedBy,
      memberDeletedDate: memberDeletedDate ?? this.memberDeletedDate,
      memberIsDeleted: memberIsDeleted ?? this.memberIsDeleted,
      memberPhotoOfVehicleFile:
          memberPhotoOfVehicleFile ?? this.memberPhotoOfVehicleFile,
      docRef: docRef ?? this.docRef,
      isLegacy: isLegacy ?? this.isLegacy,
    );
  }

  @override
  List<Object?> get props => [
        memberId,
        memberName,
        memberEmail,
        memberPhoneNumber,
        memberGender,
        memberDateOfBirth,
        memberAddress,
        memberPhotoOfVehicle,
        memberYearOfVehicle,
        memberNoVehicle,
        memberTypeOfVehicle,
        memberColorOfVehicle,
        memberBrandOfVehicle,
        memberSizeOfVehicle,
        memberTypeOfMember,
        memberStatusMember,
        memberJoinDate,
        memberExpiredDate,
        memberRegistrationDate,
        memberJoinPartner,
        memberCreatedBy,
        memberCreatedDate,
        memberUpdatedBy,
        memberUpdatedDate,
        memberDeletedBy,
        memberDeletedDate,
        memberIsDeleted,
        memberPhotoOfVehicleFile,
        docRef,
        isLegacy,
      ];
}
