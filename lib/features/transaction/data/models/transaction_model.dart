import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/user/data/models/user_model.dart';
import 'package:project_nineties/features/user/domain/entities/user_entity.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.transactionId,
    required super.member,
    required super.partner,
    required super.user,
    required super.transactionType,
    required super.transactionDate,
    super.transactionAmount,
    super.transactionDescription,
    required super.transactionStatus,
    required super.createdBy,
    required super.createdDate,
    super.updatedBy,
    super.updatedDate,
    super.deletedBy,
    super.deletedDate,
    required super.isDeleted,
  });

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    try {
      return TransactionModel(
        transactionId: entity.transactionId,
        member: entity.member,
        partner: entity.partner,
        user: entity.user,
        transactionType: entity.transactionType,
        transactionDate: entity.transactionDate,
        transactionAmount: entity.transactionAmount,
        transactionDescription: entity.transactionDescription,
        transactionStatus: entity.transactionStatus,
        createdBy: entity.createdBy,
        createdDate: entity.createdDate,
        updatedBy: entity.updatedBy,
        updatedDate: entity.updatedDate,
        deletedBy: entity.deletedBy,
        deletedDate: entity.deletedDate,
        isDeleted: entity.isDeleted,
      );
    } catch (e) {
      debugPrint('Error in fromEntity: $e');
      rethrow;
    }
  }

  TransactionEntity toEntity() {
    try {
      return TransactionEntity(
        transactionId: transactionId,
        member: member,
        partner: partner,
        user: user,
        transactionType: transactionType,
        transactionDate: transactionDate,
        transactionAmount: transactionAmount,
        transactionDescription: transactionDescription,
        transactionStatus: transactionStatus,
        createdBy: createdBy,
        createdDate: createdDate,
        updatedBy: updatedBy,
        updatedDate: updatedDate,
        deletedBy: deletedBy,
        deletedDate: deletedDate,
        isDeleted: isDeleted,
      );
    } catch (e) {
      debugPrint('Error in TransactionModel.toEntity: $e');
      rethrow;
    }
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    try {
      return TransactionModel(
        transactionId: json['transaction_id'] as String,
        member: MemberModel.fromJson(json['member']).toEntity(),
        partner: PartnerModel.fromJson(json['partner']).toEntity(),
        user: UserModel.fromJson(json['user']).toEntity(),
        transactionType: json['transaction_type'] as String,
        transactionDate: DateTime.parse(json['transaction_date'] as String),
        transactionAmount: (json['transaction_amount'] as num?)?.toDouble(),
        transactionDescription: json['transaction_description'] as String?,
        transactionStatus: json['transaction_status'] as String,
        createdBy: json['created_by'] as String,
        createdDate: DateTime.parse(json['created_date'] as String),
        updatedBy: json['updated_by'] as String?,
        updatedDate: json['updated_date'] != null
            ? DateTime.parse(json['updated_dateupdated_date'] as String)
            : null,
        deletedBy: json['deleted_by'] as String?,
        deletedDate: json['deleted_date'] != null
            ? DateTime.parse(json['deleted_date'] as String)
            : null,
        isDeleted: json['is_deleted'] as bool,
      );
    } catch (e) {
      debugPrint('Error in TransactionModel.fromJson: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'transaction_id': transactionId,
        'member': MemberModel.fromEntity(member).toJson(),
        'partner': PartnerModel.fromEntity(partner).toJson(),
        'user': UserModel.fromEntity(user).toJson(),
        'transaction_type': transactionType,
        'transaction_date': transactionDate.toIso8601String(),
        'transaction_amount': transactionAmount,
        'transaction_description': transactionDescription,
        'transaction_status': transactionStatus,
        'created_by': createdBy,
        'created_date': createdDate.toIso8601String(),
        'updated_by': updatedBy,
        'updated_date': updatedDate?.toIso8601String(),
        'deleted_by': deletedBy,
        'deleted_date': deletedDate?.toIso8601String(),
        'is_deleted': isDeleted,
      };
    } catch (e) {
      debugPrint('Error in TransactionModel.toJson: $e');
      rethrow;
    }
  }

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    try {
      return TransactionModel(
        transactionId: snapshot.id,
        member: MemberModel.fromMap(data['member']).toEntity(),
        partner: PartnerModel.fromJson(data['partner']).toEntity(),
        user: UserModel.fromTransactionJson(data['user']).toEntity(),
        transactionType: data['transaction_type'] as String,
        transactionDate: (data['transaction_date'] as Timestamp).toDate(),
        transactionAmount: (data['transaction_amount'] as num?)?.toDouble(),
        transactionDescription: data['transaction_description'] as String?,
        transactionStatus: data['transaction_status'] as String,
        createdBy: data['created_by'] as String,
        createdDate: (data['created_date'] as Timestamp).toDate(),
        updatedBy: data['updated_by'] as String?,
        updatedDate: (data['updated_date'] as Timestamp?)?.toDate(),
        deletedBy: data['deleted_by'] as String?,
        deletedDate: (data['deleted_date'] as Timestamp?)?.toDate(),
        isDeleted: data['is_deleted'] as bool,
      );
    } catch (e) {
      debugPrint('Error in TransactionModel.fromFirestore: $e');
      rethrow;
    }
  }

  // factory TransactionModel.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   print(snapshot.data());
  //   try {
  //     return TransactionModel(
  //       transactionId: snapshot.id,
  //       member: MemberModel.fromJson(snapshot['member']).toEntity(),
  //       partner: PartnerModel.fromJson(snapshot['partner']).toEntity(),
  //       user: UserModel.fromJson(snapshot['user']).toEntity(),
  //       transactionType: snapshot['transaction_type'] as String,
  //       transactionDate: (snapshot['transaction_date'] as Timestamp).toDate(),
  //       transactionAmount: (snapshot['transaction_amount'] as num?)?.toDouble(),
  //       transactionDescription: snapshot['transaction_description'] as String?,
  //       transactionStatus: snapshot['transaction_status'] as String,
  //       createdBy: snapshot['created_by'] as String,
  //       createdDate: (snapshot['created_date'] as Timestamp).toDate(),
  //       updatedBy: snapshot['updated_by'] as String?,
  //       updatedDate: (snapshot['updated_date'] as Timestamp?)?.toDate(),
  //       deletedBy: snapshot['deleted_by'] as String?,
  //       deletedDate: (snapshot['deleted_date'] as Timestamp?)?.toDate(),
  //       isDeleted: snapshot['is_deleted'] as bool,
  //     );
  //   } catch (e) {
  //     debugPrint('Error in TransactionModel.fromFirestore: $e');
  //     rethrow;
  //   }
  // }

  // Map<String, dynamic> toFirestore() {
  //   try {
  //     return {
  //       'transaction_id': transactionId,
  //       'member': MemberModel.fromEntity(member).toFireStore(),
  //       'partner': PartnerModel.fromEntity(partner).toFireStore(),
  //       'user': UserModel.fromEntity(user).toFirestore(),
  //       'transaction_type': transactionType,
  //       'transaction_date': transactionDate.toIso8601String(),
  //       'transaction_amount': transactionAmount,
  //       'transaction_description': transactionDescription,
  //       'transaction_status': transactionStatus,
  //       'created_by': createdBy,
  //       'created_date': createdDate.toIso8601String(),
  //       'updated_by': updatedBy,
  //       'updated_date': updatedDate?.toIso8601String(),
  //       'deleted_by': deletedBy,
  //       'deleted_date': deletedDate?.toIso8601String(),
  //       'is_deleted': isDeleted,
  //     };
  //   } catch (e) {
  //     debugPrint('Error in TransactionModel.toFirestore: $e');
  //     rethrow;
  //   }
  // }

  Map<String, dynamic> toFirestore() {
    try {
      return {
        'transaction_id': transactionId,
        'member': MemberModel.fromEntity(member).toFireStore(),
        'partner': PartnerModel.fromEntity(partner).toFireStore(),
        'user': UserModel.fromEntity(user).toFirestore(),
        'transaction_type': transactionType,
        'transaction_date': transactionDate,
        'transaction_amount': transactionAmount,
        'transaction_description': transactionDescription,
        'transaction_status': transactionStatus,
        'created_by': createdBy,
        'created_date': createdDate,
        'updated_by': updatedBy,
        'updated_date': updatedDate,
        'deleted_by': deletedBy,
        'deleted_date': deletedDate,
        'is_deleted': isDeleted,
      };
    } catch (e) {
      debugPrint('Error in TransactionModel.toFirestore: $e');
      rethrow;
    }
  }

  static final empty = TransactionModel(
    transactionId: '',
    member: MemberEntity.empty,
    partner: PartnerEntity.empty,
    user: UserEntity.empty,
    transactionType: 'carwash',
    transactionDate: DateTime(1970, 1, 1),
    transactionStatus: '',
    createdBy: '',
    createdDate: DateTime(1970, 1, 1),
    isDeleted: false,
  );

  List<TextCellValue> toTextCellValueHeader() {
    return [
      TextCellValue('Transaction Id'),
      TextCellValue('Member'),
      TextCellValue('Partner Id'),
      TextCellValue('User Id'),
      TextCellValue('Transaction Type'),
      TextCellValue('Transaction Date'),
      TextCellValue('Transaction Amount'),
      TextCellValue('Transaction Description'),
      TextCellValue('Transaction Status'),
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
      TextCellValue(transactionId),
      TextCellValue(member.memberId),
      TextCellValue(partner.partnerId),
      TextCellValue(user.id),
      TextCellValue(transactionType),
      TextCellValue(transactionDate.toIso8601String()),
      TextCellValue(transactionAmount?.toString() ?? ''),
      TextCellValue(transactionDescription ?? ''),
      TextCellValue(transactionStatus),
      TextCellValue(createdBy),
      TextCellValue(createdDate.toIso8601String()),
      TextCellValue(updatedBy ?? ''),
      TextCellValue(updatedDate?.toIso8601String() ?? ''),
      TextCellValue(deletedBy ?? ''),
      TextCellValue(deletedDate?.toIso8601String() ?? ''),
      TextCellValue(isDeleted.toString()),
    ];
  }

  List<String> toCSVHeader() {
    return [
      'transaction_id',
      'member_id',
      'partner_id',
      'user_id',
      'transaction_type',
      'transaction_date',
      'transaction_amount',
      'transaction_description',
      'transaction_status',
      'created_by',
      'created_date',
      'updated_by',
      'updated_date',
      'deleted_by',
      'deleted_date',
      'is_deleted',
    ];
  }

  List<String> toCSVList() {
    return [
      transactionId,
      member.memberId,
      partner.partnerId,
      user.id,
      transactionType,
      transactionDate.toIso8601String(),
      transactionAmount?.toString() ?? '',
      transactionDescription ?? '',
      transactionStatus,
      createdBy,
      createdDate.toIso8601String(),
      updatedBy ?? '',
      updatedDate?.toIso8601String() ?? '',
      deletedBy ?? '',
      deletedDate?.toIso8601String() ?? '',
      isDeleted.toString(),
    ];
  }

  @override
  bool get isEmpty => this == TransactionModel.empty;
  @override
  bool get isNotEmpty => this != TransactionModel.empty;

  @override
  TransactionModel copyWith({
    String? transactionId,
    MemberEntity? member,
    PartnerEntity? partner,
    UserEntity? user,
    String? transactionType,
    DateTime? transactionDate,
    double? transactionAmount,
    String? transactionDescription,
    String? transactionStatus,
    String? createdBy,
    DateTime? createdDate,
    String? updatedBy,
    DateTime? updatedDate,
    String? deletedBy,
    DateTime? deletedDate,
    bool? isDeleted,
  }) {
    try {
      return TransactionModel(
        transactionId: transactionId ?? this.transactionId,
        member: member ?? this.member,
        partner: partner ?? this.partner,
        user: user ?? this.user,
        transactionType: transactionType ?? this.transactionType,
        transactionDate: transactionDate ?? this.transactionDate,
        transactionAmount: transactionAmount ?? this.transactionAmount,
        transactionDescription:
            transactionDescription ?? this.transactionDescription,
        transactionStatus: transactionStatus ?? this.transactionStatus,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        updatedBy: updatedBy ?? this.updatedBy,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedDate: deletedDate ?? this.deletedDate,
        isDeleted: isDeleted ?? this.isDeleted,
      );
    } catch (e) {
      debugPrint('Error in copyWith: $e');
      rethrow;
    }
  }
}
