import 'dart:io' as io;
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:universal_html/html.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:project_nineties/core/usecases/address.dart';
import 'package:project_nineties/core/usecases/join_date.dart';
import 'package:project_nineties/core/usecases/name.dart';
import 'package:project_nineties/core/usecases/phone.dart';
import 'package:project_nineties/features/authentication/domain/usecases/email.dart';

class PartnerParams extends Equatable {
  final String partnerId;
  final String partnerName;
  final String partnerEmail;
  final String partnerPhoneNumber;
  final String partnerImageUrl;
  final String partnerAddress;
  final String partnerStatus;
  final DateTime partnerJoinDate;
  final String? partnerCreatedBy;
  final DateTime? partnerCreatedDate;
  final String? partnerUpdatedBy;
  final DateTime? partnerUpdatedDate;
  final String? partnerDeletedBy;
  final DateTime? partnerDeletedDate;
  final bool? partnerIsDeleted;
  final io.File? partnerAvatarFile;
  final File? partnerAvatarFileWeb;

  const PartnerParams({
    required this.partnerId,
    required this.partnerName,
    required this.partnerEmail,
    required this.partnerImageUrl,
    required this.partnerAddress,
    required this.partnerPhoneNumber,
    required this.partnerStatus,
    required this.partnerJoinDate,
    this.partnerCreatedBy,
    this.partnerCreatedDate,
    this.partnerUpdatedBy,
    this.partnerUpdatedDate,
    this.partnerDeletedBy,
    this.partnerDeletedDate,
    this.partnerIsDeleted,
    this.partnerAvatarFile,
    this.partnerAvatarFileWeb,
  });

  bool get isNameValid => Name.dirty(partnerName.toString()).isValid;
  bool get isEmailValid => Email.dirty(partnerEmail.toString()).isValid;
  bool get isPhoneNumberValid =>
      Phone.dirty(partnerPhoneNumber.toString()).isValid;
  bool get isCompanyAddressValid =>
      Address.dirty(partnerAddress.toString()).isValid;
  bool get isjoinDate =>
      JoinDate.dirty(maskDate(partnerJoinDate.toString())).isValid;

  bool get isValid {
    final name = Name.dirty(partnerName);
    final email = Email.dirty(partnerEmail);
    final phone = Phone.dirty(partnerPhoneNumber);
    final address = Address.dirty(partnerAddress);
    final joinDate = JoinDate.dirty(maskDate(partnerJoinDate.toString()));

    return Formz.validate([
      name,
      email,
      phone,
      address,
      joinDate,
    ]);
  }

  factory PartnerParams.fromPartnerModel(PartnerModel model) {
    return PartnerParams(
      partnerId: model.partnerId,
      partnerName: model.partnerName ?? '',
      partnerEmail: model.partnerEmail ?? '',
      partnerPhoneNumber: model.partnerPhoneNumber ?? '',
      partnerImageUrl: model.partnerImageUrl ?? '',
      partnerAddress: model.partnerAddress ?? '',
      partnerStatus: model.partnerStatus ?? '',
      partnerJoinDate: model.partnerJoinDate ?? DateTime.now(),
      partnerCreatedBy: model.partnerCreatedBy,
      partnerCreatedDate: model.partnerCreatedDate,
      partnerUpdatedBy: model.partnerUpdatedBy,
      partnerUpdatedDate: model.partnerUpdatedDate,
      partnerDeletedBy: model.partnerDeletedBy,
      partnerDeletedDate: model.partnerDeletedDate,
      partnerIsDeleted: model.partnerIsDeleted,
      partnerAvatarFile: model.partnerAvatarFile,
      partnerAvatarFileWeb: model.partnerAvatarFileWeb,
    );
  }

  PartnerParams copyWith({
    String? partnerId,
    String? partnerName,
    String? partnerEmail,
    String? partnerPhoneNumber,
    String? partnerImageUrl,
    String? partnerAddress,
    String? partnerStatus,
    DateTime? partnerJoinDate,
    String? partnerCreatedBy,
    DateTime? partnerCreatedDate,
    String? partnerUpdatedBy,
    DateTime? partnerUpdatedDate,
    String? partnerDeletedBy,
    DateTime? partnerDeletedDate,
    bool? partnerIsDeleted,
    io.File? partnerAvatarFile,
    File? partnerAvatarFileWeb,
  }) {
    return PartnerParams(
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      partnerEmail: partnerEmail ?? this.partnerEmail,
      partnerPhoneNumber: partnerPhoneNumber ?? this.partnerPhoneNumber,
      partnerImageUrl: partnerImageUrl ?? this.partnerImageUrl,
      partnerAddress: partnerAddress ?? this.partnerAddress,
      partnerStatus: partnerStatus ?? this.partnerStatus,
      partnerJoinDate: partnerJoinDate ?? this.partnerJoinDate,
      partnerCreatedBy: partnerCreatedBy ?? this.partnerCreatedBy,
      partnerCreatedDate: partnerCreatedDate ?? this.partnerCreatedDate,
      partnerUpdatedBy: partnerUpdatedBy ?? this.partnerUpdatedBy,
      partnerUpdatedDate: partnerUpdatedDate ?? this.partnerUpdatedDate,
      partnerDeletedBy: partnerDeletedBy ?? this.partnerDeletedBy,
      partnerDeletedDate: partnerDeletedDate ?? this.partnerDeletedDate,
      partnerIsDeleted: partnerIsDeleted ?? this.partnerIsDeleted,
      partnerAvatarFile: partnerAvatarFile ?? this.partnerAvatarFile,
      partnerAvatarFileWeb: partnerAvatarFileWeb ?? this.partnerAvatarFileWeb,
    );
  }

  @override
  List<Object?> get props => [
        partnerId,
        partnerName,
        partnerEmail,
        partnerPhoneNumber,
        partnerImageUrl,
        partnerAddress,
        partnerStatus,
        partnerJoinDate,
        partnerCreatedBy,
        partnerCreatedDate,
        partnerUpdatedBy,
        partnerUpdatedDate,
        partnerDeletedBy,
        partnerDeletedDate,
        partnerIsDeleted,
        partnerAvatarFile,
        partnerAvatarFileWeb,
      ];
}
