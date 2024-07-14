import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_dob_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_expired_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_join_date_cubit.dart';

class CustomerCustomTextField extends StatelessWidget {
  const CustomerCustomTextField({
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
    final bool readOnly = type == InputType.joinDate ||
            type == InputType.dOBDate ||
            type == InputType.expiredDate
        ? true
        : false;

    void onTaped() {
      if (type == InputType.joinDate) {
        context.read<CustomerJoinDateCubit>().onJoinDateChanged(context);
      }
      if (type == InputType.dOBDate) {
        context.read<CustomerDOBDateCubit>().onDOBDateChanged(context);
      }
      if (type == InputType.expiredDate) {
        context.read<CustomerExpiredDateCubit>().onExpiredDateChanged(context);
      }
    }

    void onChanged(String value) {
      final customerParams = context.read<CustomerValidatorBloc>().state.data;
      final currentUser = context.read<AppBloc>().state.user;
      final joinDate = context.read<CustomerJoinDateCubit>().state;
      final expiredDate = context.read<CustomerExpiredDateCubit>().state;
      final dOBDate = context.read<CustomerDOBDateCubit>().state;

      CustomerEntity updatedParams = customerParams.copyWith(
        customerJoinDate:
            customerParams.customerJoinDate != DateTime(1970, 1, 1)
                ? customerParams.customerJoinDate
                : DateTime.now(),
        customerExpiredDate:
            customerParams.customerExpiredDate != DateTime(1970, 1, 1)
                ? customerParams.customerExpiredDate
                : DateTime.now(),
        customerDateOfBirth:
            customerParams.customerDateOfBirth != DateTime(1970, 1, 1)
                ? customerParams.customerDateOfBirth
                : DateTime.now(),
        customerCreatedBy: currentUser.user.id,
        customerCreatedDate:
            customerParams.customerCreatedDate ?? DateTime.now(),
        customerIsDeleted: customerParams.customerIsDeleted ?? false,
      );

      switch (type) {
        case InputType.name:
          updatedParams = updatedParams.copyWith(customerName: value);
          break;
        case InputType.email:
          updatedParams = updatedParams.copyWith(customerEmail: value);
          break;
        case InputType.phone:
          updatedParams = updatedParams.copyWith(customerPhoneNumber: value);
          break;
        case InputType.dOBDate:
          updatedParams = updatedParams.copyWith(customerDateOfBirth: dOBDate);
          break;
        case InputType.vehicleNo:
          updatedParams = updatedParams.copyWith(customerNoVehicle: value);
          break;
        case InputType.vehicleType:
          updatedParams = updatedParams.copyWith(customerTypeOfVehicle: value);
          break;
        case InputType.vehicleColor:
          updatedParams = updatedParams.copyWith(customerColorOfVehicle: value);
          break;
        case InputType.joinDate:
          updatedParams = updatedParams.copyWith(customerJoinDate: joinDate);
          break;
        case InputType.expiredDate:
          updatedParams =
              updatedParams.copyWith(customerExpiredDate: expiredDate);
          break;
        default:
          break;
      }

      context
          .read<CustomerValidatorBloc>()
          .add(CustomerValidatorForm(params: updatedParams));
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
      suffixIcon:
          BlocBuilder<CustomerValidatorBloc, CustomerValidatorBlocState>(
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
                              : type == InputType.vehicleType
                                  ? currentParams.isTypeOfVehicleValid
                                  : type == InputType.vehicleColor
                                      ? currentParams.isColorOfVehicleValid
                                      : type == InputType.memberType
                                          ? currentParams.isTypeOfMemberValid
                                          : type == InputType.joinDate
                                              ? currentParams.isJoinDateValid
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
      ),
    );
  }
}
