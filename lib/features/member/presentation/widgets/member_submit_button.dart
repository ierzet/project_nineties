import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/member/data/models/member_history.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_bloc/member_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberSubmitButton extends StatelessWidget {
  const MemberSubmitButton({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    //final validationMessage = ScaffoldMessenger.of(context);
    final updatedUser = context.watch<AppBloc>().state.user.user.id;
    void onSubmit() {
      MemberEntity memberParams =
          context.read<MemberValidatorBloc>().state.data;

      final initiateGender = memberParams.memberGender;
      final initiateDOB = memberParams.memberDateOfBirth == DateTime(1970, 1, 1)
          ? DateTime.now().subtract(const Duration(days: 365 * 10))
          : memberParams.memberDateOfBirth;
      final initiateVehicleType = memberParams.memberTypeOfVehicle;

      final initiateVehicleBrand = memberParams.memberBrandOfVehicle;

      final initiateSizeOfVehicle = memberParams.memberSizeOfVehicle;

      final initateTypeOfMember = memberParams.memberTypeOfMember;

      final bool initiateStatusMember = memberParams.memberStatusMember ?? true;

      final initiateRegistrationDate =
          memberParams.memberRegistrationDate == DateTime(1970, 1, 1)
              ? DateTime.now()
              : memberParams.memberRegistrationDate;
      final initiateJoinDate =
          memberParams.memberJoinDate == DateTime(1970, 1, 1)
              ? DateTime.now()
              : memberParams.memberJoinDate;
      final initiateExpiredDate =
          memberParams.memberExpiredDate == DateTime(1970, 1, 1)
              ? DateTime.now()
              : memberParams.memberExpiredDate;

      final membershipHistory = MembershipHistory(
        joinDate: initiateJoinDate,
        expiredDate: initiateExpiredDate,
        typeOfMember: initateTypeOfMember,
        historyDate: DateTime.now(),
        joinPartner: memberParams.memberJoinPartner,
      );

      List<MembershipHistory>? initiateMembershipHistoryList =
          memberParams.membershipHistory ?? [];

      //print('Before copyWith: ${memberParams.membershipHistory}');

      if (type == 'update' && initiateMembershipHistoryList.isNotEmpty) {
        initiateMembershipHistoryList.removeLast();
      }

      initiateMembershipHistoryList.add(membershipHistory);

      //Update memberParams with the new membership history list
      memberParams = memberParams.copyWith(
          membershipHistory: initiateMembershipHistoryList);

      //print('After copyWith: ${memberParams.membershipHistory}');
      type == 'register'
          ? context.read<MemberBloc>().add(MemberRegister(
                context: context,
                params: memberParams.copyWith(
                  memberGender: initiateGender,
                  memberDateOfBirth: initiateDOB,
                  memberTypeOfVehicle: initiateVehicleType,
                  memberBrandOfVehicle: initiateVehicleBrand,
                  memberSizeOfVehicle: initiateSizeOfVehicle,
                  memberTypeOfMember: initateTypeOfMember,
                  memberStatusMember: initiateStatusMember,
                  memberRegistrationDate: initiateRegistrationDate,
                  memberJoinDate: initiateJoinDate,
                  memberExpiredDate: initiateExpiredDate,
                  isLegacy: false,
                ),
              ))
          : type == 'update'
              ? context.read<MemberBloc>().add(MemberUpdateData(
                    context: context,
                    params: memberParams.copyWith(
                        memberUpdatedBy: updatedUser,
                        memberUpdatedDate: DateTime.now()),
                  ))
              : context.read<MemberBloc>().add(MemberExtend(
                    context: context,
                    params: memberParams.copyWith(
                        memberUpdatedBy: updatedUser,
                        memberUpdatedDate: DateTime.now()),
                  ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
          ),
          elevation: AppPadding.halfPadding.r / 2,
          // Add your gradient background here if needed
          // primary: AppColors.primary, // Set primary color if needed
        ),
        child: Center(
          child: BlocBuilder<MemberBloc, MemberState>(
            builder: (context, state) {
              return state is MemberLoadInProgress
                  // ? const CircularProgressIndicator(
                  //     // color: AppColors.background,
                  //     )
                  ? const CircularProgressIndicator(
                      color: AppColors.info,
                    )
                  : Text(
                      'Submit',
                      style: AppStyles.buttonText.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
