// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

// class MembershipHistory extends Equatable {
//   final DateTime? joinDate;
//   final DateTime? expiredDate;
//   final String? typeOfMember;
//   final PartnerEntity? joinPartner;

//   const MembershipHistory({
//     this.joinDate,
//     this.expiredDate,
//     this.typeOfMember,
//     this.joinPartner,
//   });

//   @override
//   List<Object?> get props => [
//         joinDate,
//         expiredDate,
//         typeOfMember,
//         joinPartner,
//       ];
// }

// class MemberEntityRestructure extends Equatable {
//   final String memberId;
//   final String? memberName;
//   final String? memberEmail;
//   final String? memberPhoneNumber;
//   final String? memberGender;
//   final DateTime? memberDateOfBirth;
//   final String? memberAddress;

//   ///////////////////////////////////
//   final String? memberPhotoOfVehicle;
//   final int? memberYearOfVehicle;
//   final String? memberNoVehicle;
//   final String? memberTypeOfVehicle;
//   final String? memberColorOfVehicle;
//   final String? memberBrandOfVehicle;
//   final String? memberSizeOfVehicle;

//   ////////////////////////////////////
//   final String? memberTypeOfMember;
//   final bool? memberStatusMember;
//   final DateTime? memberJoinDate;
//   final DateTime? memberExpiredDate;
//   final DateTime? memberRegistrationDate;
//   final PartnerEntity? memberJoinPartner; // Assuming PartnerEntity is defined
//   final List<MembershipHistory>? membershipHistory;
//   ///////////////////////////////////
//   final String? memberCreatedBy;
//   final DateTime? memberCreatedDate;
//   final String? memberUpdatedBy;
//   final DateTime? memberUpdatedDate;
//   final String? memberDeletedBy;
//   final DateTime? memberDeletedDate;
//   final bool? memberIsDeleted;
//   final Uint8List? memberPhotoOfVehicleFile;
//   final DocumentSnapshot? docRef;
//   final bool? isLegacy;

//   const MemberEntityRestructure({
//     required this.memberId,
//     this.memberName,
//     this.memberEmail,
//     this.memberPhoneNumber,
//     this.memberGender,
//     this.memberDateOfBirth,
//     this.memberAddress,
//     this.memberPhotoOfVehicle,
//     this.memberYearOfVehicle,
//     this.memberNoVehicle,
//     this.memberTypeOfVehicle,
//     this.memberColorOfVehicle,
//     this.memberBrandOfVehicle,
//     this.memberSizeOfVehicle,
//     this.memberTypeOfMember,
//     this.memberStatusMember,
//     this.memberJoinDate,
//     this.memberExpiredDate,
//     this.memberRegistrationDate,
//     this.memberJoinPartner,
//     this.membershipHistory,
//     this.memberCreatedBy,
//     this.memberCreatedDate,
//     this.memberUpdatedBy,
//     this.memberUpdatedDate,
//     this.memberDeletedBy,
//     this.memberDeletedDate,
//     this.memberIsDeleted,
//     this.memberPhotoOfVehicleFile,
//     this.docRef,
//     this.isLegacy,
//   });

//   @override
//   List<Object?> get props => [
//         memberId,
//         memberName,
//         memberEmail,
//         memberPhoneNumber,
//         memberGender,
//         memberDateOfBirth,
//         memberAddress,
//         memberPhotoOfVehicle,
//         memberYearOfVehicle,
//         memberNoVehicle,
//         memberTypeOfVehicle,
//         memberColorOfVehicle,
//         memberBrandOfVehicle,
//         memberSizeOfVehicle,
//         memberTypeOfMember,
//         memberStatusMember,
//         memberJoinDate,
//         memberExpiredDate,
//         memberRegistrationDate,
//         memberJoinPartner,
//         membershipHistory,
//         memberCreatedBy,
//         memberCreatedDate,
//         memberUpdatedBy,
//         memberUpdatedDate,
//         memberDeletedBy,
//         memberDeletedDate,
//         memberIsDeleted,
//         memberPhotoOfVehicleFile,
//         docRef,
//         isLegacy,
//       ];
// }






// /*
// 1. Remove DocumentSnapshot from the Entity
// The DocumentSnapshot reference should not belong in the entity, as it tightly couples the entity to Firestore. Instead, parse the DocumentSnapshot into the entity at the repository or data layer.

// Modify your entity like this:

// class MemberEntityRestructure extends Equatable {
//   final String memberId;
//   final String? memberName;
//   final String? memberEmail;
//   final String? memberPhoneNumber;
//   final String? memberGender;
//   final DateTime? memberDateOfBirth;
//   final String? memberAddress;

//   ///////////////////////////////////
//   final String? memberPhotoOfVehicle;
//   final int? memberYearOfVehicle;
//   final String? memberNoVehicle;
//   final String? memberTypeOfVehicle;
//   final String? memberColorOfVehicle;
//   final String? memberBrandOfVehicle;
//   final String? memberSizeOfVehicle;

//   ////////////////////////////////////
//   final List<MembershipHistory>? membershipHistory;
//   final bool? memberStatusMember;
//   final DateTime? memberRegistrationDate;

//   ///////////////////////////////////
//   final String? memberCreatedBy;
//   final DateTime? memberCreatedDate;
//   final String? memberUpdatedBy;
//   final DateTime? memberUpdatedDate;
//   final String? memberDeletedBy;
//   final DateTime? memberDeletedDate;
//   final bool? memberIsDeleted;
//   final Uint8List? memberPhotoOfVehicleFile;
//   final bool? isLegacy;

//   const MemberEntityRestructure({
//     required this.memberId,
//     this.memberName,
//     this.memberEmail,
//     this.memberPhoneNumber,
//     this.memberGender,
//     this.memberDateOfBirth,
//     this.memberAddress,
//     this.memberPhotoOfVehicle,
//     this.memberYearOfVehicle,
//     this.memberNoVehicle,
//     this.memberTypeOfVehicle,
//     this.memberColorOfVehicle,
//     this.memberBrandOfVehicle,
//     this.memberSizeOfVehicle,
//     this.membershipHistory,
//     this.memberStatusMember,
//     this.memberRegistrationDate,
//     this.memberCreatedBy,
//     this.memberCreatedDate,
//     this.memberUpdatedBy,
//     this.memberUpdatedDate,
//     this.memberDeletedBy,
//     this.memberDeletedDate,
//     this.memberIsDeleted,
//     this.memberPhotoOfVehicleFile,
//     this.isLegacy,
//   });

//   @override
//   List<Object?> get props => [
//         memberId,
//         memberName,
//         memberEmail,
//         memberPhoneNumber,
//         memberGender,
//         memberDateOfBirth,
//         memberAddress,
//         memberPhotoOfVehicle,
//         memberYearOfVehicle,
//         memberNoVehicle,
//         memberTypeOfVehicle,
//         memberColorOfVehicle,
//         memberBrandOfVehicle,
//         memberSizeOfVehicle,
//         membershipHistory,
//         memberStatusMember,
//         memberRegistrationDate,
//         memberCreatedBy,
//         memberCreatedDate,
//         memberUpdatedBy,
//         memberUpdatedDate,
//         memberDeletedBy,
//         memberDeletedDate,
//         memberIsDeleted,
//         memberPhotoOfVehicleFile,
//         isLegacy,
//       ];
// }
// 2. Create a Mapper Class
// You can create a separate mapper class to convert a DocumentSnapshot into a MemberEntityRestructure.

// import 'package:cloud_firestore/cloud_firestore.dart';

// class MemberMapper {
//   static MemberEntityRestructure fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;

//     return MemberEntityRestructure(
//       memberId: snapshot.id,
//       memberName: data['memberName'] as String?,
//       memberEmail: data['memberEmail'] as String?,
//       memberPhoneNumber: data['memberPhoneNumber'] as String?,
//       memberGender: data['memberGender'] as String?,
//       memberDateOfBirth: (data['memberDateOfBirth'] as Timestamp?)?.toDate(),
//       memberAddress: data['memberAddress'] as String?,
//       memberPhotoOfVehicle: data['memberPhotoOfVehicle'] as String?,
//       memberYearOfVehicle: data['memberYearOfVehicle'] as int?,
//       memberNoVehicle: data['memberNoVehicle'] as String?,
//       memberTypeOfVehicle: data['memberTypeOfVehicle'] as String?,
//       memberColorOfVehicle: data['memberColorOfVehicle'] as String?,
//       memberBrandOfVehicle: data['memberBrandOfVehicle'] as String?,
//       memberSizeOfVehicle: data['memberSizeOfVehicle'] as String?,
//       membershipHistory: (data['membershipHistory'] as List?)
//           ?.map((e) => MembershipHistory.fromMap(e as Map<String, dynamic>))
//           .toList(),
//       memberStatusMember: data['memberStatusMember'] as bool?,
//       memberRegistrationDate:
//           (data['memberRegistrationDate'] as Timestamp?)?.toDate(),
//       memberCreatedBy: data['memberCreatedBy'] as String?,
//       memberCreatedDate: (data['memberCreatedDate'] as Timestamp?)?.toDate(),
//       memberUpdatedBy: data['memberUpdatedBy'] as String?,
//       memberUpdatedDate: (data['memberUpdatedDate'] as Timestamp?)?.toDate(),
//       memberDeletedBy: data['memberDeletedBy'] as String?,
//       memberDeletedDate: (data['memberDeletedDate'] as Timestamp?)?.toDate(),
//       memberIsDeleted: data['memberIsDeleted'] as bool?,
//       memberPhotoOfVehicleFile: data['memberPhotoOfVehicleFile'] as Uint8List?,
//       isLegacy: data['isLegacy'] as bool?,
//     );
//   }

//   static Map<String, dynamic> toMap(MemberEntityRestructure member) {
//     return {
//       'memberName': member.memberName,
//       'memberEmail': member.memberEmail,
//       'memberPhoneNumber': member.memberPhoneNumber,
//       'memberGender': member.memberGender,
//       'memberDateOfBirth': member.memberDateOfBirth,
//       'memberAddress': member.memberAddress,
//       'memberPhotoOfVehicle': member.memberPhotoOfVehicle,
//       'memberYearOfVehicle': member.memberYearOfVehicle,
//       'memberNoVehicle': member.memberNoVehicle,
//       'memberTypeOfVehicle': member.memberTypeOfVehicle,
//       'memberColorOfVehicle': member.memberColorOfVehicle,
//       'memberBrandOfVehicle': member.memberBrandOfVehicle,
//       'memberSizeOfVehicle': member.memberSizeOfVehicle,
//       'membershipHistory': member.membershipHistory
//           ?.map((e) => e.toMap())
//           .toList(),
//       'memberStatusMember': member.memberStatusMember,
//       'memberRegistrationDate': member.memberRegistrationDate,
//       'memberCreatedBy': member.memberCreatedBy,
//       'memberCreatedDate': member.memberCreatedDate,
//       'memberUpdatedBy': member.memberUpdatedBy,
//       'memberUpdatedDate': member.memberUpdatedDate,
//       'memberDeletedBy': member.memberDeletedBy,
//       'memberDeletedDate': member.memberDeletedDate,
//       'memberIsDeleted': member.memberIsDeleted,
//       'memberPhotoOfVehicleFile': member.memberPhotoOfVehicleFile,
//       'isLegacy': member.isLegacy,
//     };
//   }
// }
// 3. Use a Repository
// The repository interacts with Firestore and uses the mapper to return clean entities.

// class MemberRepository {
//   final FirebaseFirestore firestore;

//   MemberRepository(this.firestore);

//   Future<MemberEntityRestructure?> getMemberById(String id) async {
//     try {
//       final snapshot = await firestore.collection('members').doc(id).get();
//       if (snapshot.exists) {
//         return MemberMapper.fromSnapshot(snapshot);
//       }
//     } catch (e) {
//       // Handle error
//       print('Error fetching member: $e');
//     }
//     return null;
//   }

//   Future<void> saveMember(MemberEntityRestructure member) async {
//     final data = MemberMapper.toMap(member);
//     await firestore.collection('members').doc(member.memberId).set(data);
//   }
// }
// Benefits
// Separation of Concerns: The entity is free from Firestore-specific details.
// Testability: You can mock the repository and test it independently of Firestore.
// Flexibility: If you switch data sources in the future, you won't need to change the entity.
// This approach ensures a clean architecture and keeps your codebase maintainable.
// */