import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_custom_texfield.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:universal_html/html.dart' as html;

class MemberMigrateDataMemberPage extends StatefulWidget {
  const MemberMigrateDataMemberPage({super.key});

  @override
  State<MemberMigrateDataMemberPage> createState() =>
      _MemberMigrateDataMemberPageState();
}

class _MemberMigrateDataMemberPageState
    extends State<MemberMigrateDataMemberPage> {
  final descriptionController = TextEditingController();
  double _uploadProgress = 0.0;
  int _totalRows = 0;
  bool _isProcessing = false;
  String? _fileName;
  Uint8List? _fileData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      backgroundColor: theme.colorScheme.surface,
      body: ResponsiveLayout(
        desktopBody: const Center(
          child: Text('Desktop Body'),
        ),
        mobileBody: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppPadding.doublePadding.h),
                  _buildIcon(theme),
                  if (_fileName != null) ...[
                    SizedBox(height: AppPadding.defaultPadding.h),
                    Text(
                      'Selected file: $_fileName',
                      style: AppStyles.bodyText.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                  SizedBox(height: AppPadding.doublePadding.h),
                  _buildHeader(theme),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  _buildSubHeader(theme),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  _buildDescriptionField(),
                  if (_isProcessing) _buildProgressUI(theme),
                  SizedBox(height: AppPadding.doublePadding.h),
                  MigrateButton(
                    fileData: _fileData,
                    onProcessing: (isProcessing) {
                      setState(() {
                        _isProcessing = isProcessing;
                      });
                    },
                    onProgress: (progress, totalRows) {
                      setState(() {
                        _uploadProgress = progress;
                        _totalRows = totalRows;
                      });
                    },
                  ),
                  SizedBox(height: AppPadding.defaultPadding.h),
                  _buildFooter(context, theme),
                  const ListenerNotificationLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    return GestureDetector(
      onTap: () => _pickExcelFile(),
      child: Icon(
        Icons.upload_file,
        size: AppPadding.triplePadding.r * 2,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Text(
      'Unggah Data Member',
      style: AppStyles.header.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildSubHeader(ThemeData theme) {
    return Text(
      'Unggah file Excel (.xlsx) untuk memigrasikan data member.',
      textAlign: TextAlign.center,
      style: AppStyles.bodyText.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildDescriptionField() {
    return MemberCustomTextField(
      controller: descriptionController,
      type: InputType.text,
      label: 'Deskripsi Migrasi',
    );
  }

  Widget _buildProgressUI(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: Column(
        children: [
          SizedBox(height: AppPadding.defaultPadding.h),
          LinearProgressIndicator(
            value: _uploadProgress,
            backgroundColor: theme.colorScheme.onSurface.withOpacity(0.2),
            color: theme.colorScheme.primary,
          ),
          SizedBox(height: AppPadding.halfPadding.h),
          Text(
            'Proses: ${(_uploadProgress * 100).toStringAsFixed(1)}% (${_totalRows} baris)',
            style: AppStyles.bodyText.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, ThemeData theme) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ingin kembali ke menu utama?',
            style: AppStyles.bodyText.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: AppPadding.halfPadding.h / 2),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              'Kembali',
              style: AppStyles.accentText.copyWith(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickExcelFile() async {
    final html.FileUploadInputElement uploadInput =
        html.FileUploadInputElement();
    uploadInput.accept = ".xlsx";
    uploadInput.click();

    uploadInput.onChange.listen((event) async {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();
        setState(() {
          _fileName = files[0].name;
        });
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((event) async {
          final data = reader.result as Uint8List;
          setState(() {
            _fileData = data;
          });
        });
      }
    });
  }
}

class MigrateButton extends StatelessWidget {
  final Uint8List? fileData;
  final Function(bool) onProcessing;
  final Function(double, int) onProgress;

  const MigrateButton({
    super.key,
    required this.fileData,
    required this.onProcessing,
    required this.onProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: ElevatedButton(
        onPressed: fileData != null ? () => _processExcelFile(context) : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
          ),
          elevation: AppPadding.halfPadding.r / 2,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Center(
          child: Text(
            'Migrate Data',
            style: AppStyles.buttonText
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }

  Future<void> _processExcelFile(BuildContext context) async {
    onProcessing(true);
    double uploadProgress = 0.0;
    int totalRows = 0;
    final snackbarMigration = ScaffoldMessenger.of(context);
    final excel = Excel.decodeBytes(fileData!);

    for (var table in excel.tables.keys) {
      final rows = excel.tables[table]?.rows ?? [];
      for (int i = 0; i < rows.length; i++) {
        // Simulate row processing (e.g., saving to server)
        await Future.delayed(const Duration(milliseconds: 50));
        totalRows += 1;
        uploadProgress = totalRows / rows.length;
        onProgress(uploadProgress, totalRows);
      }
    }

    onProcessing(false);

    // Optionally, show a snackbar or message when done
    snackbarMigration.showSnackBar(
      SnackBar(content: Text('Proses selesai. Total baris: $totalRows')),
    );
  }
}
