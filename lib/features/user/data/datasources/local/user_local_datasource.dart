import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/error/failure.dart';

abstract class UserLocalDataSource {
  Future<String> exportToExcel(Excel params);
  Future<String> exportToCSV(Uint8List params);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl();

  @override
  Future<String> exportToCSV(Uint8List params) async {
    final String fileName =
        'Report_User_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}';
    const MimeType mimeTypeCSV = MimeType.microsoftExcel;
    const String extension = 'csv';
    final Uint8List csvData = params;
    String message = '';
    try {
      if (kIsWeb) {
        await FileSaver.instance.saveFile(
          name: fileName,
          ext: extension,
          bytes: csvData,
          mimeType: mimeTypeCSV,
        );
        message = 'CSV file saved successfully!';
      } else {
        await FileSaver.instance.saveAs(
          name: fileName,
          ext: extension,
          bytes: csvData,
          mimeType: mimeTypeCSV,
        );
        message = 'CSV file saved successfully! Check your chosen directory.';
      }

      return message;
    } catch (e) {
      if (e is ExportToCSV) {
        rethrow;
      } else {
        return 'Error exporting data to CSV: $e';
      }
    }
  }

  @override
  Future<String> exportToExcel(Excel params) async {
    final List<int>? encodedData = params.encode();
    if (encodedData == null) {
      throw const ExportToExcel('Failed to encode Excel data.');
    }
    final fileExcel = Uint8List.fromList(encodedData);
    final String fileName =
        'Report_User_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}';
    const String extension = 'xlsx';
    var microsoftExcel = MimeType.microsoftExcel;
    String message = '';
    try {
      if (kIsWeb) {
        await FileSaver.instance.saveFile(
            name: fileName,
            ext: extension,
            bytes: fileExcel,
            mimeType: microsoftExcel);
        message = 'Excel file saved successfully!';
      } else {
        await FileSaver.instance.saveAs(
            name: fileName,
            ext: extension,
            mimeType: microsoftExcel,
            bytes: fileExcel);
        message = 'Excel file saved successfully! Check your chosen directory.';
      }

      return message;
    } catch (e) {
      if (e is ExportToExcel) {
        rethrow;
      } else {
        return 'Error exporting data to Excel: $e';
      }
    }
  }
}
