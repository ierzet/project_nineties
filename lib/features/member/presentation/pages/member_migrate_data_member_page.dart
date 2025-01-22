import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/responsive_display.dart';
import 'package:project_nineties/features/authentication/presentation/widgets/listener_notify_login.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_migrate_params_cubit.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_migrate_button.dart';

class MemberMigrateDataMemberPage extends StatelessWidget {
  const MemberMigrateDataMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final theme = Theme.of(context);

    final memberMigrateParamsCubit = context.read<MemberMigrateParamsCubit>();
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
              child: BlocBuilder<MemberMigrateParamsCubit,
                  MemberMigrateParamsState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppPadding.doublePadding.h),
                      GestureDetector(
                        onTap: () => memberMigrateParamsCubit.pickExcelFile(),
                        child: Icon(
                          Icons.upload_file,
                          size: AppPadding.triplePadding.r * 2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      if (state.fileName != null) ...[
                        SizedBox(height: AppPadding.defaultPadding.h),
                        Text(
                          'Selected file: ${state.fileName}',
                          style: AppStyles.bodyText.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                      SizedBox(height: AppPadding.doublePadding.h),
                      Text(
                        'Unggah Data Member',
                        style: AppStyles.header.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      Text(
                        'Unggah file Excel (.xlsx) untuk memigrasikan data member.',
                        textAlign: TextAlign.center,
                        style: AppStyles.bodyText.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.halfPadding.w * 3),
                        child: TextField(
                          onTap: () {},
                          onChanged: (value) {},
                          controller: descriptionController,
                          // keyboardType: InputType.text,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            labelText: 'Deskripsi  Migrasi',
                            labelStyle: AppStyles.bodyText,
                            filled: true,
                            hintStyle: const TextStyle(),
                          ),
                        ),
                      ),
                      if (state.isProcessing)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.halfPadding.w * 3),
                          child: Column(
                            children: [
                              SizedBox(height: AppPadding.defaultPadding.h),
                              LinearProgressIndicator(
                                value: state.uploadProgress,
                                backgroundColor: theme.colorScheme.onSurface
                                    .withOpacity(0.2),
                                color: theme.colorScheme.primary,
                              ),
                              SizedBox(height: AppPadding.halfPadding.h),
                              Text(
                                'Proses: ${(state.uploadProgress * 100).toStringAsFixed(1)}% (${state.totalRows} baris)',
                                style: AppStyles.bodyText.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: AppPadding.doublePadding.h),
                      const MigrateButton(),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      // if (state.listMember != null &&
                      //     state.listMember!.isNotEmpty &&
                      //     !state.isProcessing)
                      //   Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: AppPadding.halfPadding.w * 3),
                      //     child: SingleChildScrollView(
                      //       scrollDirection: Axis.horizontal,
                      //       child: DataTable(
                      //         columns: const [
                      //           DataColumn(label: Text('Nama')),
                      //           DataColumn(label: Text('Email')),
                      //           DataColumn(label: Text('No. Kendaraan')),
                      //         ],
                      //         rows: state.listMember!.map((member) {
                      //           return DataRow(cells: [
                      //             DataCell(
                      //                 Text(member.memberName ?? 'No Data')),
                      //             DataCell(
                      //                 Text(member.memberEmail ?? 'No Data')),
                      //             DataCell(Text(
                      //                 member.memberNoVehicle ?? 'No Data')),
                      //           ]);
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      Center(
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
                      ),
                      const ListenerNotificationLogin(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
