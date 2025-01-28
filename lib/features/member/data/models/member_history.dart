import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class MembershipHistory extends Equatable {
  final DateTime? joinDate;
  final DateTime? expiredDate;
  final String? typeOfMember;
  final DateTime? historyDate;
  final PartnerEntity? joinPartner;

  const MembershipHistory({
    this.joinDate,
    this.expiredDate,
    this.historyDate,
    this.typeOfMember,
    this.joinPartner,
  });

  static const empty = MembershipHistory(
    joinDate: null,
    expiredDate: null,
    typeOfMember: null,
    historyDate: null,
    joinPartner: null,
  );

  // Convert the object to JSON with error handling
  Map<String, dynamic> toJson() {
    try {
      return {
        'join_date': joinDate?.toIso8601String(),
        'expired_date': expiredDate?.toIso8601String(),
        'type_of_member': typeOfMember,
        'history_date': historyDate?.toIso8601String(),
        'join_partner':
            PartnerModel.fromEntity(joinPartner ?? PartnerEntity.empty)
                .toJson(),
      };
    } catch (e, stackTrace) {
      // Log the error or handle it as needed
      debugPrint('Error converting MembershipHistory to JSON: $e');
      debugPrint('Stack trace: $stackTrace');

      // Optionally, return an empty or partial map
      return {};
    }
  }

  // Create the object from JSON with error handling
  factory MembershipHistory.fromJson(Map<String, dynamic> json) {
    try {
      return MembershipHistory(
        joinDate: json['join_date'] != null
            ? DateTime.parse(json['join_date'])
            : null,
        expiredDate: json['expired_date'] != null
            ? DateTime.parse(json['expired_date'])
            : null,
        typeOfMember: json['type_of_member'],
        historyDate: json['history_date'] != null
            ? DateTime.parse(json['history_date'])
            : null,
        joinPartner: json['join_partner'] != null
            ? PartnerModel.fromMap(json['join_partner']).toEntity()
            : null,
      );
    } catch (e, stackTrace) {
      // Log the error or handle it as needed
      debugPrint(
          'Error parsing MembershipHistory MembershipHistory.fromJson: $e');
      debugPrint('Stack trace: $stackTrace');

      // Optionally, throw the error or return a default/empty object
      rethrow; // Re-throws the error to be handled further up the call stack
      // Alternatively:
      // return MembershipHistory.empty;
    }
  }

  Map<String, dynamic> toFirestore() {
    try {
      return {
        'join_date': joinDate != null ? Timestamp.fromDate(joinDate!) : null,
        'expired_date':
            expiredDate != null ? Timestamp.fromDate(expiredDate!) : null,
        'type_of_member': typeOfMember,
        'history_date':
            historyDate != null ? Timestamp.fromDate(historyDate!) : null,
        'join_partner': joinPartner != null
            ? PartnerModel.fromEntity(joinPartner!).toJson()
            : null,
      };
    } catch (e, stackTrace) {
      print('Error converting MembershipHistory to Firestore: $e');
      print('Stack trace: $stackTrace');
      return {};
    }
  }

  

  // Create the object from Firestore data with error handling
  factory MembershipHistory.fromFirestore(Map<String, dynamic> firestoreData) {
    //print(firestoreData['join_partner']);
    try {
      return MembershipHistory(
        joinDate: parseDateApp(firestoreData['join_date']),
        expiredDate: parseDateApp(firestoreData['expired_date']),
        typeOfMember: firestoreData['type_of_member'],
        historyDate: parseDateApp(firestoreData['history_date']),
        joinPartner: firestoreData['join_partner'] != null
            ? PartnerModel.fromMap(
                    Map<String, dynamic>.from(firestoreData['join_partner']))
                .toEntity()
            : PartnerEntity.empty,
      );
    } catch (e, stackTrace) {
      print('Error creating MembershipHistory from Firestore: $e');
      print('Stack trace: $stackTrace');
      // Return an empty instance if there's an error
      return MembershipHistory.empty;
    }
  }

  @override
  List<Object?> get props => [
        joinDate,
        expiredDate,
        historyDate,
        typeOfMember,
        joinPartner,
      ];
}
