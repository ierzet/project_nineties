import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/data/models/member_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

class MemberMigrateParamsCubit extends Cubit<MemberMigrateParamsState> {
  MemberMigrateParamsCubit() : super(MemberMigrateParamsState.empty);

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.last;
      emit(state.copyWith(
        fileData: file.bytes,
        fileName: file.name,
      ));
    }
  }

  Future<void> processExcelFile(BuildContext context) async {
    emit(state.copyWith(isProcessing: true));
    double uploadProgress = 0.0;
    int totalRows = 0;
    final snackbarMigration = ScaffoldMessenger.of(context);
    final excel = Excel.decodeBytes(state.fileData!);
    List<MemberModel> members = [];
    const int batchSize = 500; // Firestore batch limit is 500 operations

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection('member')
    //     .where('member_created_by', isEqualTo: 'migrated by system')
    //     .get();

    // // Check if there are any documents to delete
    // if (querySnapshot.docs.isNotEmpty) {
    //   // Create a batch for deletion
    //   WriteBatch batch = FirebaseFirestore.instance.batch();

    //   // Iterate over the documents and add them to the batch for deletion
    //   for (var doc in querySnapshot.docs) {
    //     batch.delete(doc.reference);
    //   }

    //   // Commit the batch to delete all documents
    //   await batch.commit();
    //   print('Deleted ${querySnapshot.docs.length} documents.');
    //   emit(state.copyWith(isProcessing: false));
    // } else {
    //   print('No documents found to delete.');
    // }

    DateTime? parseDate(dynamic date) {
      //print(date.runtimeType);
      if (date == null) return null;
      if (date is DateCellValue) {
        // Convert TextCellValue to String
        String stringValue = date.toString();
        // Assuming 'text' is the property that gives you the string
        try {
          return DateTime.parse(stringValue);
        } catch (e) {
          return null;
        }
      }
      if (date is DateTime) return date;
      if (date is String) {
        try {
          return DateTime.parse(date);
        } catch (e) {
          return null;
        }
      }
      return null;
    }

    bool? parseBool(dynamic value) {
      if (value == null) {
        return null;
      }

      // Check if the value is of type TextCellValue
      if (value is TextCellValue) {
        // Convert TextCellValue to String
        String stringValue = value
            .toString(); // Assuming 'text' is the property that gives you the string
        bool containsActive = stringValue.toUpperCase().contains('ACTIVE');

        return containsActive;
      }

      // If it's a regular string, handle it as before
      if (value is String) {
        bool containsActive = value.toUpperCase().contains('ACTIVE');

        return containsActive;
      }

      return null;
    }

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value);
      }
      return null;
    }

    for (var table in excel.tables.keys) {
      final rows = excel.tables[table]?.rows ?? [];
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < rows.length; i++) {
        if (i > 0) {
          // if (i == 10) {
          //   break;
          // }
          final row = rows[i];

          final member = MemberModel(
            memberId: '',
            memberJoinDate: parseDate(row[1]?.value),
            memberEmail: row[2]?.value.toString(),
            memberName: row[3]?.value.toString() ?? '',
            memberNoVehicle: row[4]?.value.toString() ?? '',
            memberTypeOfVehicle: row[5]?.value.toString() ?? '',
            memberBrandOfVehicle: row[6]?.value.toString() ?? '',
            memberColorOfVehicle: row[7]?.value.toString() ?? '',
            memberYearOfVehicle: parseInt(row[8]?.value),
            memberTypeOfMember: row[9]?.value.toString(),
            memberStatusMember: parseBool(row[10]?.value),
            memberPhoneNumber: row[11]?.value.toString(),
            // memberPhotoOfVehicle: row[12]?.value.toString(),
            memberSizeOfVehicle: row[13]?.value.toString(),
            memberExpiredDate: parseDate(row[14]?.value),
            memberJoinPartner: PartnerEntity.empty,
            memberCreatedBy: 'migrated by system',
            memberCreatedDate: DateTime.now(),
            memberIsDeleted: false,
            isLegacy: true,
          );

          members.add(member);

          final docRef = FirebaseFirestore.instance
              .collection(AppCollection.memberCollection)
              .doc();
          batch.set(docRef, member.toFireStore());

          totalRows += 1;
          uploadProgress = totalRows / rows.length;
          emit(state.copyWith(
              uploadProgress: uploadProgress,
              totalRows: totalRows,
              listMember: members));

          if (totalRows % batchSize == 0) {
            await batch.commit();
            batch = FirebaseFirestore.instance.batch();
          }
        }
      }

      if (totalRows % batchSize != 0) {
        await batch.commit();
      }
    }

    emit(state.copyWith(isProcessing: false));

    snackbarMigration.showSnackBar(
      SnackBar(content: Text('Proses selesai. Total baris: $totalRows')),
    );
  }
}

class MemberMigrateParamsState extends Equatable {
  const MemberMigrateParamsState({
    this.listMember,
    this.description,
    required this.uploadProgress,
    required this.totalRows,
    required this.isProcessing,
    this.fileName,
    this.fileData,
  });
  final List<MemberModel>? listMember;
  final String? description;
  final double uploadProgress;
  final int totalRows;
  final bool isProcessing;
  final String? fileName;
  final Uint8List? fileData;

  static const empty = MemberMigrateParamsState(
    uploadProgress: 0.0,
    totalRows: 0,
    isProcessing: false,
  );

  bool get isEmpty => this == MemberMigrateParamsState.empty;
  bool get isNotEmpty => this != MemberMigrateParamsState.empty;

  MemberMigrateParamsState copyWith({
    List<MemberModel>? listMember,
    String? description,
    double? uploadProgress,
    int? totalRows,
    bool? isProcessing,
    String? fileName,
    Uint8List? fileData,
  }) {
    return MemberMigrateParamsState(
      listMember: listMember ?? this.listMember,
      description: description ?? this.description,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      totalRows: totalRows ?? this.totalRows,
      isProcessing: isProcessing ?? this.isProcessing,
      fileName: fileName ?? this.fileName,
      fileData: fileData ?? this.fileData,
    );
  }

  @override
  List<Object?> get props => [
        listMember,
        description,
        uploadProgress,
        totalRows,
        isProcessing,
        fileName,
        fileData,
      ];
}


// final excel = Excel.decodeBytes(state.fileData!);
//     int totalRowsExcel = state.totalRows;
//     double uploadProgressExcel = 0.0;
//     Function(double, int) onProgress;

//     for (var table in excel.tables.keys) {
//       final rows = excel.tables[table]?.rows ?? [];
//       for (int i = 0; i < rows.length; i++) {
//         // Simulate row processing (e.g., saving to server)
//         await Future.delayed(const Duration(milliseconds: 50));
//         totalRowsExcel += 1;
//         uploadProgressExcel = totalRowsExcel / rows.length;
//         onProgress(uploadProgress, totalRows);
//       }
//     }