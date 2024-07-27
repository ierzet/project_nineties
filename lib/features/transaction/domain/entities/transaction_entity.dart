import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/user/domain/entities/user_entity.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class TransactionEntity extends Equatable {
  final String transactionId;
  final CustomerEntity customer;
  final PartnerEntity partner;
  final UserEntity user;
  final String transactionType;
  final DateTime transactionDate;
  final double? transactionAmount;
  final String? transactionDescription;
  final String transactionStatus;
  final String createdBy;
  final DateTime createdDate;
  final String? updatedBy;
  final DateTime? updatedDate;
  final String? deletedBy;
  final DateTime? deletedDate;
  final bool isDeleted;

  const TransactionEntity({
    required this.transactionId,
    required this.customer,
    required this.partner,
    required this.user,
    required this.transactionType,
    required this.transactionDate,
    this.transactionAmount,
    this.transactionDescription,
    required this.transactionStatus,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.deletedBy,
    this.deletedDate,
    required this.isDeleted,
  });

  static final empty = TransactionEntity(
    transactionId: '',
    customer: CustomerEntity.empty,
    partner: PartnerEntity.empty,
    user: UserEntity.empty,
    transactionType: '',
    transactionDate: DateTime(1970, 1, 1),
    transactionStatus: 'carwash',
    createdBy: '',
    createdDate: DateTime(1970, 1, 1),
    isDeleted: false,
  );

  bool get isEmpty => this == TransactionEntity.empty;
  bool get isNotEmpty => this != TransactionEntity.empty;

  TransactionEntity copyWith({
    String? transactionId,
    CustomerEntity? customer,
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
    return TransactionEntity(
      transactionId: transactionId ?? this.transactionId,
      customer: customer ?? this.customer,
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
  }

  @override
  List<Object?> get props => [
        transactionId,
        customer,
        partner,
        user,
        transactionType,
        transactionDate,
        transactionAmount,
        transactionDescription,
        transactionStatus,
        createdBy,
        createdDate,
        updatedBy,
        updatedDate,
        deletedBy,
        deletedDate,
        isDeleted,
      ];
}
