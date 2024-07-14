import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.customerId,
    super.customerName,
    super.customerEmail,
    super.customerPhoneNumber,
    super.customerGender,
    super.customerDateOfBirth,
    super.customerNoVehicle,
    super.customerTypeOfVehicle,
    super.customerColorOfVehicle,
    super.customerTypeOfMember,
    bool? customerStatusMember,
    super.customerJoinDate,
    super.customerExpiredDate,
    super.customerCreatedBy,
    super.customerCreatedDate,
    super.customerUpdatedBy,
    super.customerUpdatedDate,
    super.customerDeletedBy,
    super.customerDeletedDate,
    super.customerIsDeleted,
  }) : super(
          customerStatusMember: true,
        );

  CustomerEntity toEntity() => CustomerEntity(
        customerId: customerId,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhoneNumber: customerPhoneNumber,
        customerGender: customerGender,
        customerDateOfBirth: customerDateOfBirth,
        customerNoVehicle: customerNoVehicle,
        customerTypeOfVehicle: customerTypeOfVehicle,
        customerColorOfVehicle: customerColorOfVehicle,
        customerTypeOfMember: customerTypeOfMember,
        customerStatusMember: customerStatusMember,
        customerJoinDate: customerJoinDate,
        customerExpiredDate: customerExpiredDate,
        customerCreatedBy: customerCreatedBy,
        customerCreatedDate: customerCreatedDate,
        customerUpdatedBy: customerUpdatedBy,
        customerUpdatedDate: customerUpdatedDate,
        customerDeletedBy: customerDeletedBy,
        customerDeletedDate: customerDeletedDate,
        customerIsDeleted: customerIsDeleted,
      );

  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      customerId: entity.customerId,
      customerName: entity.customerName,
      customerEmail: entity.customerEmail,
      customerPhoneNumber: entity.customerPhoneNumber,
      customerGender: entity.customerGender,
      customerDateOfBirth: entity.customerDateOfBirth,
      customerNoVehicle: entity.customerNoVehicle,
      customerTypeOfVehicle: entity.customerTypeOfVehicle,
      customerColorOfVehicle: entity.customerColorOfVehicle,
      customerTypeOfMember: entity.customerTypeOfMember,
      customerStatusMember: entity.customerStatusMember,
      customerJoinDate: entity.customerJoinDate,
      customerExpiredDate: entity.customerExpiredDate,
      customerCreatedBy: entity.customerCreatedBy,
      customerCreatedDate: entity.customerCreatedDate,
      customerUpdatedBy: entity.customerUpdatedBy,
      customerUpdatedDate: entity.customerUpdatedDate,
      customerDeletedBy: entity.customerDeletedBy,
      customerDeletedDate: entity.customerDeletedDate,
      customerIsDeleted: entity.customerIsDeleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone_number': customerPhoneNumber,
      'customer_gender': customerGender,
      'customer_date_of_birth': customerDateOfBirth,
      'customer_no_vehicle': customerNoVehicle,
      'customer_type_of_vehicle': customerTypeOfVehicle,
      'customer_color_of_vehicle': customerColorOfVehicle,
      'customer_type_of_member': customerTypeOfMember,
      'customer_status_member': customerStatusMember,
      'customer_join_date': customerJoinDate,
      'customer_expired_date': customerExpiredDate,
      'customer_created_by': customerCreatedBy,
      'customer_creadted_date': customerCreatedDate,
      'customer_updated_by': customerUpdatedBy,
      'customer_updated_date': customerUpdatedDate,
      'customer_deleted_by': customerDeletedBy,
      'customer_deleted_date': customerDeletedDate,
      'customer_is_deleted': customerIsDeleted,
    };
  }

  Map<String, dynamic> toFireStore() {
    return {
      // 'customer_id': customerId,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone_number': customerPhoneNumber,
      'customer_gender': customerGender ?? 'Male',
      'customer_date_of_birth': customerDateOfBirth,
      'customer_no_vehicle': customerNoVehicle,
      'customer_type_of_vehicle': customerTypeOfVehicle,
      'customer_color_of_vehicle': customerColorOfVehicle,
      'customer_type_of_member': customerTypeOfMember ?? 'Platinum',
      'customer_status_member': customerStatusMember ?? true,
      'customer_join_date': customerJoinDate,
      'customer_expired_date': customerExpiredDate,
      'customer_created_by': customerCreatedBy,
      'customer_creadted_date': customerCreatedDate,
      'customer_updated_by': customerUpdatedBy,
      'customer_updated_date': customerUpdatedDate,
      'customer_deleted_by': customerDeletedBy,
      'customer_deleted_date': customerDeletedDate,
      'customer_is_deleted': customerIsDeleted,
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerEmail: json['customer_email'] ?? '',
      customerPhoneNumber: json['customer_phone_number'] ?? '',
      customerGender: json['customer_gender'] ?? '',
      customerDateOfBirth: json['customer_date_of_birth'] as DateTime?,
      customerNoVehicle: json['customer_no_vehicle'] ?? '',
      customerTypeOfVehicle: json['customer_type_of_vehicle'] ?? '',
      customerColorOfVehicle: json['customer_color_of_vehicle'] ?? '',
      customerTypeOfMember: json['customer_type_of_member'] ?? '',
      customerStatusMember: json['customer_status_member'],
      customerJoinDate: json['customer_join_date'] as DateTime?,
      customerExpiredDate: json['customer_expired_date'] as DateTime?,
      customerCreatedBy: json['customer_created_by'] ?? '',
      customerCreatedDate: json['customer_created_date'] as DateTime?,
      customerUpdatedBy: json['customer_updated_by'] ?? '',
      customerUpdatedDate: json['customer_updated_date'] as DateTime?,
      customerDeletedBy: json['customer_deleted_by'] ?? '',
      customerDeletedDate: json['customer_deleted_date'] as DateTime?,
      customerIsDeleted: json['customer_is_deleted'] ?? false,
    );
  }

  factory CustomerModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {}; // Initialize with an empty map if null
    try {
      return CustomerModel(
        customerId: snapshot.id,
        customerName: data['customer_name'] ?? '',
        customerEmail: data['customer_email'] ?? '',
        customerPhoneNumber: data['customer_phone_number'] ?? '',
        customerGender: data['customer_gender'] ?? '',
        customerDateOfBirth:
            (data['customer_date_of_birth'] as Timestamp?)?.toDate(),
        customerNoVehicle: data['customer_no_vehicle'] ?? '',
        customerTypeOfVehicle: data['customer_type_of_vehicle'] ?? '',
        customerColorOfVehicle: data['customer_color_of_vehicle'] ?? '',
        customerTypeOfMember: data['customer_type_of_member'] ?? '',
        customerStatusMember: data['customer_status_member'],
        customerJoinDate: (data['customer_join_date'] as Timestamp?)?.toDate(),
        customerExpiredDate:
            (data['customer_expired_date'] as Timestamp?)?.toDate(),
        customerCreatedBy: data['customer_created_by'] ?? '',
        customerCreatedDate:
            (data['customer_created_date'] as Timestamp?)?.toDate(),
        customerUpdatedBy: data['customer_updated_by'] ?? '',
        customerUpdatedDate:
            (data['customer_updated_date'] as Timestamp?)?.toDate(),
        customerDeletedBy: data['customer_deleted_by'] ?? '',
        customerDeletedDate:
            (data['customer_deleted_date'] as Timestamp?)?.toDate(),
        customerIsDeleted: data['customer_is_deleted'] ?? false,
      );
    } catch (e) {
      debugPrint('Error in CustomerModel.fromFirestore: $e');
      rethrow; // Rethrow the exception for better debugging
    }
  }

  @override
  CustomerModel copyWith({
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
    return CustomerModel(
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

  // factory CustomerModel.fromParams(CustomerParams params) {
  //   final newCustomerExpiredDate = DateTime(
  //     params.customerJoinDate.year,
  //     params.customerJoinDate.month + int.parse(params.customerDuration),
  //     params.customerJoinDate.day,
  //   );
  //   return CustomerModel(
  //     customerId: 'param',
  //     customerName: params.customerName,
  //     customerEmail: params.customerEmail,
  //     customerPhoneNumber: params.customerPhoneNumber,
  //     customerGender: params.customerGender,
  //     customerDateOfBirth: params.customerDateOfBirth,
  //     customerNoVehicle: params.customerNoVehicle,
  //     customerTypeOfVehicle: params.customerTypeOfVehicle,
  //     customerColorOfVehicle: params.customerColorOfVehicle,
  //     customerTypeOfMember: params.customerTypeOfMember,
  //     customerStatusMember: params.customerStatusMember,
  //     customerJoinDate: params.customerJoinDate,
  //     customerExpiredDate: newCustomerExpiredDate,
  //     customerCreatedBy: params.customerCreatedBy,
  //     customerCreatedDate: DateTime.now(),
  //     customerUpdatedBy: params.customerUpdatedBy,
  //     customerUpdatedDate: params.customerUpdatedDate,
  //     customerDeletedBy: params.customerDeletedBy,
  //     customerDeletedDate: params.customerDeletedDate,
  //     customerIsDeleted: params.customerIsDeleted ?? false,
  //   );
  // }

  static const empty = CustomerModel(customerId: '');
  @override
  bool get isEmpty => this == CustomerModel.empty;
  @override
  bool get isNotEmpty => this != CustomerModel.empty;
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
