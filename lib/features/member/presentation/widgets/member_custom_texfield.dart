import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_dob_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_expired_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_join_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_registration_date_cubit.dart';

class MemberCustomTextField extends StatelessWidget {
  const MemberCustomTextField({
    super.key,
    required this.controller,
    required this.type,
    required this.label,
    this.isEnabled,
  });

  final TextEditingController controller;
  final InputType type;
  final String label;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    final bool readOnly = type == InputType.joinDate ||
            type == InputType.dOBDate ||
            type == InputType.expiredDate ||
            type == InputType.registrationDate
        ? true
        : false;

    void onTaped() {
      if (type == InputType.joinDate) {
        context.read<MemberJoinDateCubit>().onJoinDateChanged(context);
      }
      if (type == InputType.dOBDate) {
        context.read<MemberDOBDateCubit>().onDOBDateChanged(context);
      }
      if (type == InputType.expiredDate) {
        context.read<MemberExpiredDateCubit>().onExpiredDateChanged(context);
      }
      if (type == InputType.registrationDate) {
        context
            .read<MemberRegistrationDateCubit>()
            .onRegistrationChanged(context);
      }
    }

    void onChanged(String value) {
      final memberParams = context.read<MemberValidatorBloc>().state.data;
      final currentUser = context.read<AppBloc>().state.user;
      final joinDate = context.read<MemberJoinDateCubit>().state;
      final expiredDate = context.read<MemberExpiredDateCubit>().state;
      final dOBDate = context.read<MemberDOBDateCubit>().state;
      final registrationDate =
          context.read<MemberRegistrationDateCubit>().state;

      MemberEntity updatedParams = memberParams.copyWith(
        memberJoinDate: memberParams.memberJoinDate != DateTime(1970, 1, 1)
            ? memberParams.memberJoinDate
            : DateTime.now(),
        memberRegistrationDate:
            memberParams.memberRegistrationDate != DateTime(1970, 1, 1)
                ? memberParams.memberRegistrationDate
                : DateTime.now(),
        memberExpiredDate:
            memberParams.memberExpiredDate != DateTime(1970, 1, 1)
                ? memberParams.memberExpiredDate
                : DateTime.now(),
        memberDateOfBirth:
            memberParams.memberDateOfBirth != DateTime(1970, 1, 1)
                ? memberParams.memberDateOfBirth
                : DateTime.now(),
        memberCreatedBy: memberParams.memberCreatedBy ?? currentUser.user.id,
        memberCreatedDate: memberParams.memberCreatedDate ?? DateTime.now(),
        memberIsDeleted: memberParams.memberIsDeleted ?? false,
      );

      switch (type) {
        case InputType.name:
          updatedParams = updatedParams.copyWith(memberName: value);
          break;
        case InputType.email:
          updatedParams = updatedParams.copyWith(memberEmail: value);
          break;
        case InputType.phone:
          updatedParams = updatedParams.copyWith(memberPhoneNumber: value);
          break;
        case InputType.dOBDate:
          updatedParams = updatedParams.copyWith(memberDateOfBirth: dOBDate);
          break;
        case InputType.registrationDate:
          updatedParams =
              updatedParams.copyWith(memberRegistrationDate: registrationDate);
          break;
        case InputType.address:
          updatedParams = updatedParams.copyWith(memberAddress: value);
          break;
        case InputType.vehicleNo:
          updatedParams = updatedParams.copyWith(memberNoVehicle: value);
          break;
        case InputType.vehicleType:
          updatedParams = updatedParams.copyWith(memberTypeOfVehicle: value);
          break;
        case InputType.vehicleColor:
          updatedParams = updatedParams.copyWith(memberColorOfVehicle: value);
          break;
        case InputType.joinDate:
          updatedParams = updatedParams.copyWith(memberJoinDate: joinDate);
          break;
        case InputType.expiredDate:
          updatedParams =
              updatedParams.copyWith(memberExpiredDate: expiredDate);
          break;
        default:
          break;
      }

      context
          .read<MemberValidatorBloc>()
          .add(MemberValidatorForm(params: updatedParams));
    }

    List<TextInputFormatter> getInputFormatters() {
      return [
        LengthLimitingTextInputFormatter(100),
        if (type == InputType.email)
          FilteringTextInputFormatter.allow(RegExp(r'[0-9@a-zA-Z.]')),
        if (type == InputType.phone)
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ];
    }

    TextInputType getKeyboardType() {
      switch (type) {
        case InputType.name:
          return TextInputType.name;
        case InputType.address:
          return TextInputType.name;
        case InputType.email:
          return TextInputType.emailAddress;
        case InputType.phone:
          return TextInputType.phone;
        case InputType.joinDate:
          return TextInputType.datetime;
        case InputType.dOBDate:
          return TextInputType.datetime;
        case InputType.registrationDate:
          return TextInputType.datetime;
        case InputType.expiredDate:
          return TextInputType.datetime;
        default:
          return TextInputType.name;
      }
    }

    final inputDecoration = InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      labelText: label,
      labelStyle: AppStyles.bodyText,
      filled: true,
      hintStyle: const TextStyle(),
      suffixIcon: BlocBuilder<MemberValidatorBloc, MemberValidatorBlocState>(
        builder: (context, state) {
          final currentParams = state.data;

          final isValid = type == InputType.name
              ? currentParams.isNameValid
              : type == InputType.email
                  ? currentParams.isEmailValid
                  : type == InputType.phone
                      ? currentParams.isPhoneValid
                      : type == InputType.dOBDate
                          ? currentParams.isDOBValid
                          : type == InputType.vehicleNo
                              ? currentParams.isNoVehicleValid
                              : type == InputType.address
                                  ? currentParams.isAddressValid
                                  : type == InputType.vehicleType
                                      ? currentParams.isTypeOfVehicleValid
                                      : type == InputType.vehicleColor
                                          ? currentParams.isColorOfVehicleValid
                                          : type == InputType.memberType
                                              ? currentParams
                                                  .isTypeOfMemberValid
                                              : type ==
                                                      InputType.registrationDate
                                                  ? currentParams
                                                      .isRegistrationDateValid
                                                  : type ==
                                                          InputType.expiredDate
                                                      ? currentParams
                                                          .isExpiredDateValid
                                                      : type ==
                                                              InputType.joinDate
                                                          ? currentParams
                                                              .isJoinDateValid
                                                          : false;

          return isValid
              ? const Icon(
                  Icons.verified,
                )
              : const SizedBox.shrink();
        },
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: TextField(
        readOnly: readOnly,
        onTap: onTaped,
        onChanged: onChanged,
        controller: controller,
        inputFormatters: getInputFormatters(),
        keyboardType: getKeyboardType(),
        decoration: inputDecoration,
        enabled: isEnabled ?? true,
      ),
    );
  }
}
