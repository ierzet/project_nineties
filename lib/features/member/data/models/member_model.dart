import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/member/data/models/member_history.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class MemberModel extends MemberEntity {
  const MemberModel({
    required super.memberId,
    super.memberName,
    super.memberEmail,
    super.memberPhoneNumber,
    super.memberGender,
    super.memberDateOfBirth,
    super.memberAddress,
    super.memberPhotoOfVehicle,
    super.memberYearOfVehicle,
    super.memberNoVehicle,
    super.memberTypeOfVehicle,
    super.memberColorOfVehicle,
    super.memberBrandOfVehicle,
    super.memberSizeOfVehicle,
    super.memberTypeOfMember,
    bool? memberStatusMember,
    super.memberJoinDate,
    super.memberExpiredDate,
    super.memberRegistrationDate,
    super.memberJoinPartner,
    super.membershipHistory,
    super.memberCreatedBy,
    super.memberCreatedDate,
    super.memberUpdatedBy,
    super.memberUpdatedDate,
    super.memberDeletedBy,
    super.memberDeletedDate,
    super.memberIsDeleted,
    super.memberPhotoOfVehicleFile,
    super.docRef,
    super.isLegacy,
  }) : super(
          memberStatusMember: memberStatusMember ?? true,
        );

  MemberEntity toEntity() => MemberEntity(
        memberId: memberId,
        memberName: memberName,
        memberEmail: memberEmail,
        memberPhoneNumber: memberPhoneNumber,
        memberGender: memberGender,
        memberDateOfBirth: memberDateOfBirth,
        memberAddress: memberAddress,
        memberPhotoOfVehicle: memberPhotoOfVehicle,
        memberYearOfVehicle: memberYearOfVehicle,
        memberNoVehicle: memberNoVehicle,
        memberTypeOfVehicle: memberTypeOfVehicle,
        memberColorOfVehicle: memberColorOfVehicle,
        memberBrandOfVehicle: memberBrandOfVehicle,
        memberSizeOfVehicle: memberSizeOfVehicle,
        memberTypeOfMember: memberTypeOfMember,
        memberStatusMember: memberStatusMember,
        memberJoinDate: memberJoinDate,
        membershipHistory: membershipHistory,
        memberExpiredDate: memberExpiredDate,
        memberRegistrationDate: memberRegistrationDate,
        memberJoinPartner: memberJoinPartner,
        memberCreatedBy: memberCreatedBy,
        memberCreatedDate: memberCreatedDate,
        memberUpdatedBy: memberUpdatedBy,
        memberUpdatedDate: memberUpdatedDate,
        memberDeletedBy: memberDeletedBy,
        memberDeletedDate: memberDeletedDate,
        memberIsDeleted: memberIsDeleted,
        memberPhotoOfVehicleFile: memberPhotoOfVehicleFile,
        docRef: docRef,
        isLegacy: isLegacy,
      );

  factory MemberModel.fromEntity(MemberEntity entity) {
    return MemberModel(
      memberId: entity.memberId,
      memberName: entity.memberName,
      memberEmail: entity.memberEmail,
      memberPhoneNumber: entity.memberPhoneNumber,
      memberGender: entity.memberGender,
      memberDateOfBirth: entity.memberDateOfBirth,
      memberAddress: entity.memberAddress,
      memberPhotoOfVehicle: entity.memberPhotoOfVehicle,
      memberYearOfVehicle: entity.memberYearOfVehicle,
      memberNoVehicle: entity.memberNoVehicle,
      memberTypeOfVehicle: entity.memberTypeOfVehicle,
      memberColorOfVehicle: entity.memberColorOfVehicle,
      memberBrandOfVehicle: entity.memberBrandOfVehicle,
      memberSizeOfVehicle: entity.memberSizeOfVehicle,
      memberTypeOfMember: entity.memberTypeOfMember,
      memberStatusMember: entity.memberStatusMember,
      memberJoinDate: entity.memberJoinDate,
      memberExpiredDate: entity.memberExpiredDate,
      memberRegistrationDate: entity.memberRegistrationDate,
      memberJoinPartner: entity.memberJoinPartner,
      membershipHistory: entity.membershipHistory,
      memberCreatedBy: entity.memberCreatedBy,
      memberCreatedDate: entity.memberCreatedDate,
      memberUpdatedBy: entity.memberUpdatedBy,
      memberUpdatedDate: entity.memberUpdatedDate,
      memberDeletedBy: entity.memberDeletedBy,
      memberDeletedDate: entity.memberDeletedDate,
      memberIsDeleted: entity.memberIsDeleted,
      memberPhotoOfVehicleFile: entity.memberPhotoOfVehicleFile,
      docRef: entity.docRef,
      isLegacy: entity.isLegacy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'member_name': memberName,
      'member_email': memberEmail,
      'member_phone_number': memberPhoneNumber,
      'member_gender': memberGender,
      'member_date_of_birth': memberDateOfBirth?.toIso8601String(),
      'member_address': memberAddress,
      'member_photo_of_vehicle': memberPhotoOfVehicle,
      'member_year_of_vehicle': memberYearOfVehicle,
      'member_no_vehicle': memberNoVehicle,
      'member_type_of_vehicle': memberTypeOfVehicle,
      'member_color_of_vehicle': memberColorOfVehicle,
      'member_brand_of_vehicle': memberBrandOfVehicle,
      'member_size_of_vehicle': memberSizeOfVehicle,
      'member_type_of_member': memberTypeOfMember,
      'member_status_member': memberStatusMember,
      'member_join_date': memberJoinDate?.toIso8601String(),
      'member_expired_date': memberExpiredDate?.toIso8601String(),
      'member_registration_date': memberRegistrationDate?.toIso8601String(),
      'member_join_partner':
          PartnerModel.fromEntity(memberJoinPartner ?? PartnerEntity.empty)
              .toJson(),
      'member_created_by': memberCreatedBy,
      'member_created_date': memberCreatedDate?.toIso8601String(),
      'member_updated_by': memberUpdatedBy,
      'member_updated_date': memberUpdatedDate?.toIso8601String(),
      'member_deleted_by': memberDeletedBy,
      'member_deleted_date': memberDeletedDate?.toIso8601String(),
      'member_is_deleted': memberIsDeleted,
      'is_legacy': isLegacy,
      'member_history': //MembershipHistory.empty,
          // membershipHistory?.map((history) => history?.toJson()).toList(),
          membershipHistory?.map((history) => history.toJson()).toList() ?? [],
    };
  }

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    try {
      List<MembershipHistory> membershipHistory = [];
      if (json['membership_history'] != null) {
        // Ensure that membership_history is a list
        for (var historyData in json['membership_history']) {
          if (historyData is Map<String, dynamic>) {
            membershipHistory.add(MembershipHistory.fromJson(historyData));
          } else {
            debugPrint('Invalid membership history data: $historyData');
          }
        }
      }

      return MemberModel(
        memberId: json['member_id'] ?? '',
        memberName: json['member_name'],
        memberEmail: json['member_email'],
        memberPhoneNumber: json['member_phone_number'],
        memberGender: json['member_gender'],
        memberDateOfBirth: json['member_date_of_birth'] != null
            ? DateTime.parse(json['member_date_of_birth'])
            : null,
        memberAddress: json['member_address'],
        memberPhotoOfVehicle: json['member_photo_of_vehicle'],
        memberYearOfVehicle: json['member_year_of_vehicle'] ?? 0,
        memberNoVehicle: json['member_no_vehicle'],
        memberTypeOfVehicle: json['member_type_of_vehicle'],
        memberColorOfVehicle: json['member_color_of_vehicle'],
        memberBrandOfVehicle: json['member_brand_of_vehicle'],
        memberSizeOfVehicle: json['member_size_of_vehicle'],
        memberTypeOfMember: json['member_type_of_member'],
        memberStatusMember: json['member_status_member'] ?? true,
        memberJoinDate: json['member_join_date'] != null
            ? DateTime.parse(json['member_join_date'])
            : null,
        memberExpiredDate: json['member_expired_date'] != null
            ? DateTime.parse(json['member_expired_date'])
            : null,
        memberRegistrationDate: json['member_registration_date'] != null
            ? DateTime.parse(json['member_registration_date'])
            : null,
        memberJoinPartner: json['member_join_partner'] != null
            ? PartnerModel.fromMap(
                    Map<String, dynamic>.from(json['member_join_partner']))
                .toEntity()
            : PartnerEntity.empty,
        memberCreatedBy: json['member_created_by'],
        memberCreatedDate: json['member_created_date'] != null
            ? DateTime.parse(json['member_created_date'])
            : null,
        memberUpdatedBy: json['member_updated_by'],
        memberUpdatedDate: json['member_updated_date'] != null
            ? DateTime.parse(json['member_updated_date'])
            : null,
        memberDeletedBy: json['member_deleted_by'],
        memberDeletedDate: json['member_deleted_date'] != null
            ? DateTime.parse(json['member_deleted_date'])
            : null,
        memberIsDeleted: json['member_is_deleted'] ?? false,
        isLegacy: json['is_legacy'],
      );
    } catch (e) {
      debugPrint('Error in MemberModel.fromJson: $e');
      rethrow; // Rethrow the exception for better debugging
    }
  }

  factory MemberModel.fromMap(Map<String, dynamic> json) {
    try {
      List<MembershipHistory> membershipHistory = [];
      if (json['membership_history'] != null) {
        // Ensure that membership_history is a list
        for (var historyData in json['membership_history']) {
          if (historyData is Map<String, dynamic>) {
            membershipHistory.add(MembershipHistory.fromFirestore(historyData));
          } else {
            debugPrint('Invalid membership history data: $historyData');
          }
        }
      }
      return MemberModel(
        memberId: json['member_id'] ?? '',
        memberName: json['member_name'],
        memberEmail: json['member_email'],
        memberPhoneNumber: json['member_phone_number'],
        memberGender: json['member_gender'],
        memberDateOfBirth: (json['member_date_of_birth'] is Timestamp)
            ? (json['member_date_of_birth'] as Timestamp).toDate()
            : null,
        memberAddress: json['member_address'],
        memberPhotoOfVehicle: json['member_photo_of_vehicle'],
        memberYearOfVehicle: json['member_year_of_vehicle'] ?? 0,
        memberNoVehicle: json['member_no_vehicle'],
        memberTypeOfVehicle: json['member_type_of_vehicle'],
        memberColorOfVehicle: json['member_color_of_vehicle'],
        memberBrandOfVehicle: json['member_brand_of_vehicle'],
        memberSizeOfVehicle: json['member_size_of_vehicle'],
        memberTypeOfMember: json['member_type_of_member'],
        memberStatusMember: json['member_status_member'] ?? true,
        memberJoinDate: (json['member_join_date'] is Timestamp)
            ? (json['member_join_date'] as Timestamp).toDate()
            : null,
        memberExpiredDate: (json['member_expired_date'] is Timestamp)
            ? (json['member_expired_date'] as Timestamp).toDate()
            : null,
        memberRegistrationDate: (json['member_registration_date'] is Timestamp)
            ? (json['member_registration_date'] as Timestamp).toDate()
            : null,
        memberJoinPartner: json['member_join_partner'] != null
            ? PartnerModel.fromMap(
                    Map<String, dynamic>.from(json['member_join_partner']))
                .toEntity()
            : PartnerEntity.empty,
        memberCreatedBy: json['member_created_by'],
        memberCreatedDate: (json['member_created_date'] is Timestamp)
            ? (json['member_created_date'] as Timestamp).toDate()
            : null,
        memberUpdatedBy: json['member_updated_by'],
        memberUpdatedDate: (json['member_updated_date'] is Timestamp)
            ? (json['member_updated_date'] as Timestamp).toDate()
            : null,
        memberDeletedBy: json['member_deleted_by'],
        memberDeletedDate: (json['member_deleted_date'] is Timestamp)
            ? (json['member_deleted_date'] as Timestamp).toDate()
            : null,
        memberIsDeleted: json['member_is_deleted'] ?? false,
        isLegacy: json['is_legacy'],
        membershipHistory: membershipHistory,
      );
    } catch (e) {
      debugPrint('Error in MemberModel.fromJson: $e');
      rethrow; // Rethrow the exception for better debugging
    }
  }

  Map<String, dynamic> toFireStore() {
    try {
      final data = {
        'member_id': memberId,
        'member_name': memberName,
        'member_email': memberEmail,
        'member_phone_number': memberPhoneNumber,
        'member_gender': memberGender,
        'member_date_of_birth': memberDateOfBirth != null
            ? Timestamp.fromDate(memberDateOfBirth!)
            : null,
        'member_address': memberAddress,
        'member_photo_of_vehicle': memberPhotoOfVehicle,
        'member_year_of_vehicle': memberYearOfVehicle,
        'member_no_vehicle': memberNoVehicle,
        'member_type_of_vehicle': memberTypeOfVehicle,
        'member_color_of_vehicle': memberColorOfVehicle,
        'member_brand_of_vehicle': memberBrandOfVehicle,
        'member_size_of_vehicle': memberSizeOfVehicle,
        'member_type_of_member': memberTypeOfMember,
        'member_status_member': memberStatusMember,
        'member_join_date':
            memberJoinDate != null ? Timestamp.fromDate(memberJoinDate!) : null,
        'member_expired_date': memberExpiredDate != null
            ? Timestamp.fromDate(memberExpiredDate!)
            : null,
        'member_registration_date': memberRegistrationDate != null
            ? Timestamp.fromDate(memberRegistrationDate!)
            : null,
        'member_join_partner':
            PartnerModel.fromEntity(memberJoinPartner ?? PartnerEntity.empty)
                .toFireStore(),
        'member_created_by': memberCreatedBy,
        'member_created_date': memberCreatedDate != null
            ? Timestamp.fromDate(memberCreatedDate!)
            : Timestamp.now(),
        'member_updated_by': memberUpdatedBy,
        'member_updated_date': memberUpdatedDate != null
            ? Timestamp.fromDate(memberUpdatedDate!)
            : null,
        'member_deleted_by': memberDeletedBy,
        'member_deleted_date': memberDeletedDate != null
            ? Timestamp.fromDate(memberDeletedDate!)
            : null,
        'member_is_deleted': memberIsDeleted,
        'is_legacy': isLegacy,
        'membership_history': membershipHistory
                ?.map((history) => history.toFirestore())
                .toList() ??
            [],
      };

      return data;
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error in toFireStore: $e');
      // Rethrow the exception for further handling
      throw Exception('Failed to convert MemberModel to Firestore data: $e');
    }
  }

  factory MemberModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    //print(data['member_join_partner']);
    try {
      List<MembershipHistory> membershipHistory = [];
      if (data['membership_history'] != null) {
        // Ensure that membership_history is a list
        for (var historyData in data['membership_history']) {
          if (historyData is Map<String, dynamic>) {
            membershipHistory.add(MembershipHistory.fromFirestore(historyData));
          } else {
            debugPrint('Invalid membership history data: $historyData');
          }
        }
      }
      return MemberModel(
        memberId: snapshot.id,
        memberName: data['member_name'],
        memberEmail: data['member_email'],
        memberPhoneNumber: data['member_phone_number'],
        memberGender: data['member_gender'],
        memberDateOfBirth:
            (data['member_date_of_birth'] as Timestamp?)?.toDate(),
        memberAddress: data['member_address'],
        memberPhotoOfVehicle: data['member_photo_of_vehicle'],
        memberYearOfVehicle: data['member_year_of_vehicle'] ?? 0,
        memberNoVehicle: data['member_no_vehicle'],
        memberTypeOfVehicle: data['member_type_of_vehicle'],
        memberColorOfVehicle: data['member_color_of_vehicle'],
        memberBrandOfVehicle: data['member_brand_of_vehicle'],
        memberSizeOfVehicle: data['member_size_of_vehicle'],
        memberTypeOfMember: data['member_type_of_member'],
        memberStatusMember: data['member_status_member'] ?? true,
        memberJoinDate: (data['member_join_date'] as Timestamp?)?.toDate(),
        memberExpiredDate:
            (data['member_expired_date'] as Timestamp?)?.toDate(),
        memberRegistrationDate:
            (data['member_registration_date'] as Timestamp?)?.toDate(),
        memberJoinPartner: data['member_join_partner'] != null
            ? PartnerModel.fromMap(
                    Map<String, dynamic>.from(data['member_join_partner']))
                .toEntity()
            : PartnerEntity.empty,
        memberCreatedBy: data['member_created_by'],
        memberCreatedDate:
            (data['member_created_date'] as Timestamp?)?.toDate(),
        memberUpdatedBy: data['member_updated_by'],
        memberUpdatedDate:
            (data['member_updated_date'] as Timestamp?)?.toDate(),
        memberDeletedBy: data['member_deleted_by'],
        memberDeletedDate:
            (data['member_deleted_date'] as Timestamp?)?.toDate(),
        memberIsDeleted: data['member_is_deleted'] ?? false,
        docRef: snapshot,
        isLegacy: data['is_legacy'],
        membershipHistory: membershipHistory,
      );
    } catch (e) {
      debugPrint('Error in MemberModel.fromFirestore: $e');
      debugPrint('Data suspected error: $data');
      rethrow; // Rethrow the exception for better debugging
    }
  }

  List<TextCellValue> toTextCellValueHeader() {
    return [
      TextCellValue('ID'),
      TextCellValue('Name'),
      TextCellValue('Email'),
      TextCellValue('Phone Number'),
      TextCellValue('Gender'),
      TextCellValue('Date of Birth'),
      TextCellValue('Address'),
      TextCellValue('Photo of Vehicle'),
      TextCellValue('Year of Vehicle'),
      TextCellValue('No Vehicle'),
      TextCellValue('Type of Vehicle'),
      TextCellValue('Color of Vehicle'),
      TextCellValue('Brand of Vehicle'),
      TextCellValue('Size of Vehicle'),
      TextCellValue('Type of Member'),
      TextCellValue('Status Member'),
      TextCellValue('Join Date'),
      TextCellValue('Expired Date'),
      TextCellValue('Registration Date'),
      TextCellValue('Created By'),
      TextCellValue('Created Date'),
      TextCellValue('Updated By'),
      TextCellValue('Updated Date'),
      TextCellValue('Deleted By'),
      TextCellValue('Deleted Date'),
      TextCellValue('Is Deleted'),
    ];
  }

  List<TextCellValue> toTextCellValueList() {
    return [
      TextCellValue(memberId),
      TextCellValue(memberName ?? ''),
      TextCellValue(memberEmail ?? ''),
      TextCellValue(memberPhoneNumber ?? ''),
      TextCellValue(memberGender ?? ''),
      TextCellValue(memberDateOfBirth?.toIso8601String() ?? ''),
      TextCellValue(memberAddress ?? ''),
      TextCellValue(memberPhotoOfVehicle ?? ''),
      TextCellValue(memberYearOfVehicle?.toString() ?? ''),
      TextCellValue(memberNoVehicle ?? ''),
      TextCellValue(memberTypeOfVehicle ?? ''),
      TextCellValue(memberColorOfVehicle ?? ''),
      TextCellValue(memberBrandOfVehicle ?? ''),
      TextCellValue(memberSizeOfVehicle ?? ''),
      TextCellValue(memberTypeOfMember ?? ''),
      TextCellValue(memberStatusMember?.toString() ?? ''),
      TextCellValue(memberJoinDate?.toIso8601String() ?? ''),
      TextCellValue(memberExpiredDate?.toIso8601String() ?? ''),
      TextCellValue(memberRegistrationDate?.toIso8601String() ?? ''),
      TextCellValue(memberCreatedBy ?? ''),
      TextCellValue(memberCreatedDate?.toIso8601String() ?? ''),
      TextCellValue(memberUpdatedBy ?? ''),
      TextCellValue(memberUpdatedDate?.toIso8601String() ?? ''),
      TextCellValue(memberDeletedBy ?? ''),
      TextCellValue(memberDeletedDate?.toIso8601String() ?? ''),
      TextCellValue(memberIsDeleted.toString()),
    ];
  }

  List<String> toCSVHeader() {
    return [
      'ID',
      'Name',
      'Email',
      'Phone Number',
      'Gender',
      'Date of Birth',
      'Address',
      'Photo of Vehicle',
      'Year of Vehicle',
      'No Vehicle',
      'Type of Vehicle',
      'Color of Vehicle',
      'Brand of Vehicle',
      'Size of Vehicle',
      'Type of Member',
      'Status Member',
      'Join Date',
      'Expired Date',
      'Registration Date',
      'Created By',
      'Created Date',
      'Updated By',
      'Updated Date',
      'Deleted By',
      'Deleted Date',
      'Is Deleted',
    ];
  }

  List<String> toCSVList() {
    return [
      memberId,
      memberName ?? '',
      memberEmail ?? '',
      memberPhoneNumber ?? '',
      memberGender ?? '',
      memberDateOfBirth?.toIso8601String() ?? '',
      memberAddress ?? '',
      memberPhotoOfVehicle ?? '',
      memberYearOfVehicle?.toString() ?? '',
      memberNoVehicle ?? '',
      memberTypeOfVehicle ?? '',
      memberColorOfVehicle ?? '',
      memberBrandOfVehicle ?? '',
      memberSizeOfVehicle ?? '',
      memberTypeOfMember ?? '',
      memberStatusMember?.toString() ?? '',
      memberJoinDate?.toIso8601String() ?? '',
      memberExpiredDate?.toIso8601String() ?? '',
      memberRegistrationDate?.toIso8601String() ?? '',
      memberCreatedBy ?? '',
      memberCreatedDate?.toIso8601String() ?? '',
      memberUpdatedBy ?? '',
      memberUpdatedDate?.toIso8601String() ?? '',
      memberDeletedBy ?? '',
      memberDeletedDate?.toIso8601String() ?? '',
      memberIsDeleted.toString(),
    ];
  }

  @override
  MemberModel copyWith({
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
    List<MembershipHistory>? membershipHistory,
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
    return MemberModel(
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
      membershipHistory: membershipHistory ?? this.membershipHistory,
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

  static const empty = MemberModel(memberId: '');
  @override
  bool get isEmpty => this == MemberModel.empty;
  @override
  bool get isNotEmpty => this != MemberModel.empty;
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
