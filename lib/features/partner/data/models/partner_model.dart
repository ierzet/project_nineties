import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';
import 'package:universal_html/html.dart';

class PartnerModel extends PartnerEntity {
  const PartnerModel({
    required super.partnerId,
    super.partnerName,
    super.partnerEmail,
    super.partnerPhoneNumber,
    super.partnerImageUrl,
    super.partnerAddress,
    super.partnerStatus,
    super.partnerJoinDate,
    super.partnerCreatedBy,
    super.partnerCreatedDate,
    super.partnerUpdatedBy,
    super.partnerUpdatedDate,
    super.partnerDeletedBy,
    super.partnerDeletedDate,
    super.partnerIsDeleted,
    super.partnerAvatarFile,
    super.partnerAvatarFileWeb,
  });
  PartnerEntity toEntity() => PartnerEntity(
        partnerId: partnerId,
        partnerName: partnerName,
        partnerEmail: partnerEmail,
        partnerPhoneNumber: partnerPhoneNumber,
        partnerImageUrl: partnerImageUrl,
        partnerAddress: partnerAddress,
        partnerStatus: partnerStatus,
        partnerJoinDate: partnerJoinDate,
        partnerCreatedBy: partnerCreatedBy,
        partnerCreatedDate: partnerCreatedDate,
        partnerUpdatedBy: partnerUpdatedBy,
        partnerUpdatedDate: partnerUpdatedDate,
        partnerDeletedBy: partnerDeletedBy,
        partnerDeletedDate: partnerDeletedDate,
        partnerIsDeleted: partnerIsDeleted,
        partnerAvatarFile: partnerAvatarFile,
        partnerAvatarFileWeb: partnerAvatarFileWeb,
      );

  factory PartnerModel.fromEntity(PartnerEntity entity) {
    return PartnerModel(
      partnerId: entity.partnerId,
      partnerName: entity.partnerName,
      partnerEmail: entity.partnerEmail,
      partnerPhoneNumber: entity.partnerPhoneNumber,
      partnerImageUrl: entity.partnerImageUrl,
      partnerAddress: entity.partnerAddress,
      partnerStatus: entity.partnerStatus,
      partnerJoinDate: entity.partnerJoinDate,
      partnerCreatedBy: entity.partnerCreatedBy,
      partnerCreatedDate: entity.partnerCreatedDate,
      partnerUpdatedBy: entity.partnerUpdatedBy,
      partnerUpdatedDate: entity.partnerUpdatedDate,
      partnerDeletedBy: entity.partnerDeletedBy,
      partnerDeletedDate: entity.partnerDeletedDate,
      partnerIsDeleted: entity.partnerIsDeleted,
      partnerAvatarFile: entity.partnerAvatarFile,
      partnerAvatarFileWeb: entity.partnerAvatarFileWeb,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partner_id': partnerId,
      'partner_name': partnerName,
      'partner_email': partnerEmail,
      'partner_phone_number': partnerPhoneNumber,
      'partner_image_url': partnerImageUrl,
      'partner_address': partnerAddress,
      'partner_status': partnerStatus,
      'partner_join_date': partnerJoinDate,
      'partner_created_by': partnerCreatedBy,
      'partner_creadted_date': partnerCreatedDate,
      'partner_updated_by': partnerUpdatedBy,
      'partner_updated_date': partnerUpdatedDate,
      'partner_deleted_by': partnerDeletedBy,
      'partner_deleted_date': partnerDeletedDate,
      'partner_is_deleted': partnerIsDeleted,
    };
  }

  Map<String, dynamic> toFireStore() {
    return {
      //partner_id menggunakan email atau jika kosong gunakan '' agar terbaca empty
      'partner_id': partnerEmail ?? partnerId,
      'partner_name': partnerName,
      'partner_email': partnerEmail,
      'partner_phone_number': partnerPhoneNumber,
      'partner_image_url': partnerImageUrl,
      'partner_address': partnerAddress,
      'partner_status_member': partnerStatus,
      'partner_join_date': partnerJoinDate,
      'partner_created_by': partnerCreatedBy,
      'partner_creadted_date': partnerCreatedDate,
      'partner_updated_by': partnerUpdatedBy,
      'partner_updated_date': partnerUpdatedDate,
      'partner_deleted_by': partnerDeletedBy,
      'partner_deleted_date': partnerDeletedDate,
      'partner_is_deleted': partnerIsDeleted,
    };
  }

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      partnerId: json['partner_id'] ?? '',
      partnerName: json['partner_name'] ?? '',
      partnerEmail: json['partner_email'] ?? '',
      partnerPhoneNumber: json['partner_phone_number'] ?? '',
      partnerImageUrl: json['partner_image_url'] ?? '',
      partnerAddress: json['partner_address'] ?? '',
      partnerStatus: json['partner_status'] ?? '',
      partnerJoinDate: (json['partner_join_date'] as Timestamp?)?.toDate(),
      partnerCreatedBy: json['partner_created_by'] ?? '',
      partnerCreatedDate:
          (json['partner_created_date'] as Timestamp?)?.toDate(),
      partnerUpdatedBy: json['partner_updated_by'] ?? '',
      partnerUpdatedDate:
          (json['partner_updated_date'] as Timestamp?)?.toDate(),
      partnerDeletedBy: json['partner_deleted_by'] ?? '',
      partnerDeletedDate:
          (json['partner_deleted_date'] as Timestamp?)?.toDate(),
      partnerIsDeleted: json['partner_is_deleted'] ?? false,
    );
  }

  factory PartnerModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    // Initialize with an empty map if null
    try {
      return PartnerModel(
        partnerId: snapshot.id,
        partnerName: data['partner_name'] ?? '',
        partnerEmail: data['partner_email'] ?? '',
        partnerPhoneNumber: data['partner_phone_number'] ?? '',
        partnerImageUrl: data['partner_image_url'] ?? '',
        partnerAddress: data['partner_address'] ?? '',
        partnerStatus: data['partner_status'] ?? '',
        partnerJoinDate: (data['partner_join_date'] as Timestamp?)?.toDate(),
        partnerCreatedBy: data['partner_created_by'] ?? '',
        partnerCreatedDate:
            (data['partner_created_date'] as Timestamp?)?.toDate(),
        partnerUpdatedBy: data['partner_updated_date'] ?? '',
        partnerUpdatedDate:
            (data['partner_updated_date'] as Timestamp?)?.toDate(),
        partnerDeletedBy: data['partner_deleted_by'] ?? '',
        partnerDeletedDate:
            (data['partner_deleted_date'] as Timestamp?)?.toDate(),
        partnerIsDeleted: data['partner_is_deleted'] ?? false,
      );
    } catch (e) {
      debugPrint('Error in fromFirestore: $e');
      rethrow; // Rethrow the exception for better debugging
    }
  }
  List<PartnerEntity> convertModelListToEntityList(List<PartnerModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  PartnerModel copyWith({
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
    return PartnerModel(
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

  factory PartnerModel.fromParams(PartnerParams params) {
    return PartnerModel(
      partnerId: 'param',
      partnerName: params.partnerName,
      partnerEmail: params.partnerEmail,
      partnerPhoneNumber: params.partnerPhoneNumber,
      partnerImageUrl: params.partnerImageUrl,
      partnerAddress: params.partnerAddress,
      partnerStatus: params.partnerStatus,
      partnerJoinDate: params.partnerJoinDate,
      partnerCreatedBy: params.partnerCreatedBy,
      partnerCreatedDate: DateTime.now(),
      partnerUpdatedBy: params.partnerUpdatedBy,
      partnerUpdatedDate: params.partnerUpdatedDate,
      partnerDeletedBy: params.partnerDeletedBy,
      partnerDeletedDate: params.partnerDeletedDate,
      partnerIsDeleted: params.partnerIsDeleted ?? false,
      partnerAvatarFile: params.partnerAvatarFile,
      partnerAvatarFileWeb: params.partnerAvatarFileWeb,
    );
  }

  static const empty = PartnerModel(partnerId: '');
  @override
  bool get isEmpty => this == PartnerModel.empty;
  @override
  bool get isNotEmpty => this != PartnerModel.empty;
  @override
  List<Object?> get props => [
        partnerId,
        partnerName,
        partnerEmail,
        partnerPhoneNumber,
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
