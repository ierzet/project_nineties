import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/cubit/partner_join_date_cubit.dart';

class PartnerCustomTextField extends StatelessWidget {
  const PartnerCustomTextField({
    super.key,
    required this.controller,
    required this.type,
    required this.label,
  });

  final TextEditingController controller;
  final InputType type;
  final String label;

  @override
  Widget build(BuildContext context) {
    final bool readOnly = type == InputType.date ? true : false;

    void onTaped() {
      if (type == InputType.date) {
        context.read<PartnerJoinDateCubit>().onJoinDateChanged(context);
      }
    }

    void onChanged(String value) {
      final partnerParams =
          context.read<PartnerValidatorBloc>().state.partnerParams;
      final currentUser = context.read<AppBloc>().state.user;
      final joinDate = context.read<PartnerJoinDateCubit>().state;

      PartnerParams updatedParams = partnerParams.copyWith(
        partnerJoinDate: partnerParams.partnerJoinDate != DateTime(1970, 1, 1)
            ? partnerParams.partnerJoinDate
            : DateTime.now(),
        partnerCreatedBy: currentUser.id,
        partnerCreatedDate: partnerParams.partnerCreatedDate ?? DateTime.now(),
        partnerIsDeleted: partnerParams.partnerIsDeleted ?? false,
      );

      switch (type) {
        case InputType.name:
          updatedParams = updatedParams.copyWith(partnerName: value);
          break;
        case InputType.address:
          updatedParams = updatedParams.copyWith(partnerAddress: value);
          break;
        case InputType.email:
          updatedParams = updatedParams.copyWith(partnerEmail: value);
          break;
        case InputType.phone:
          updatedParams = updatedParams.copyWith(partnerPhoneNumber: value);
          break;
        default:
          updatedParams = updatedParams.copyWith(partnerJoinDate: joinDate);
          break;
      }

      context
          .read<PartnerValidatorBloc>()
          .add(PartnerValidatorForm(partnerParams: updatedParams));
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
        case InputType.address:
          return TextInputType.name;
        case InputType.email:
          return TextInputType.emailAddress;
        case InputType.phone:
          return TextInputType.phone;
        default:
          return TextInputType.datetime;
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
      suffixIcon: BlocBuilder<PartnerValidatorBloc, PartnerValidatorBlocState>(
        builder: (context, state) {
          final currentParams = state.partnerParams;
          final isValid = type == InputType.name
              ? currentParams.isNameValid
              : type == InputType.address
                  ? currentParams.isCompanyAddressValid
                  : type == InputType.email
                      ? currentParams.isEmailValid
                      : type == InputType.phone
                          ? currentParams.isPhoneNumberValid
                          : currentParams.isjoinDate;

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
      ),
    );
  }
}
