import 'dart:io' as io;
import 'package:equatable/equatable.dart';
import 'package:universal_html/html.dart';

class PartnerEntity extends Equatable {
  final String partnerId;
  final String? partnerName;
  final String? partnerEmail;
  final String? partnerPhoneNumber;
  final String? partnerImageUrl;
  final String? partnerAddress;
  final String? partnerStatus;
  final DateTime? partnerJoinDate;
  final String? partnerCreatedBy;
  final DateTime? partnerCreatedDate;
  final String? partnerUpdatedBy;
  final DateTime? partnerUpdatedDate;
  final String? partnerDeletedBy;
  final DateTime? partnerDeletedDate;
  final bool? partnerIsDeleted;
  final io.File? partnerAvatarFile;
  final File? partnerAvatarFileWeb;

  const PartnerEntity({
    required this.partnerId,
    this.partnerName,
    this.partnerEmail,
    this.partnerImageUrl,
    this.partnerAddress,
    this.partnerPhoneNumber,
    this.partnerStatus,
    this.partnerJoinDate,
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

  static const empty = PartnerEntity(partnerId: '');

  bool get isEmpty => this == PartnerEntity.empty;
  bool get isNotEmpty => this != PartnerEntity.empty;

  //use the copyWith method to create copies of your partnerEntity
  //objects with modified properties. For example:
  //partnerEntity updatedpartner = partner.copyWith(partnerName: 'New Name');

  PartnerEntity copyWith({
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
    return PartnerEntity(
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      partnerEmail: partnerEmail ?? this.partnerEmail,
      partnerPhoneNumber: partnerPhoneNumber ?? this.partnerPhoneNumber,
      partnerImageUrl: partnerImageUrl ?? this.partnerImageUrl,
      partnerAddress: partnerAddress ?? this.partnerAddress,
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
