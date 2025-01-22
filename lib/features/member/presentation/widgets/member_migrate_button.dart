import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_migrate_params_cubit.dart';

class MigrateButton extends StatelessWidget {
  const MigrateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final memberMigrateParamsCubit = context.read<MemberMigrateParamsCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: BlocBuilder<MemberMigrateParamsCubit, MemberMigrateParamsState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.fileData != null
                ? () => memberMigrateParamsCubit.processExcelFile(context)
                : null,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppPadding.defaultPadding.r),
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
          );
        },
      ),
    );
  }
}
