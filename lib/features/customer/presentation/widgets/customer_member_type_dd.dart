import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';

class CustomerTypeOfMemberDd extends StatelessWidget {
  const CustomerTypeOfMemberDd({super.key, required this.initialValue});

  final String initialValue;

  @override
  Widget build(BuildContext context) {
    String selectedTypeOfMember = initialValue;
    final customerValidatorBloc = context.read<CustomerValidatorBloc>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: DropdownButtonFormField<String>(
        value: selectedTypeOfMember,
        onChanged: (newValue) {
          final customerValidatorState = customerValidatorBloc.state.data;
          if (newValue != null) {
            selectedTypeOfMember = newValue;
            customerValidatorBloc.add(CustomerValidatorForm(
                params: customerValidatorState.copyWith(
                    customerTypeOfMember: selectedTypeOfMember)));
          }
        },
        items: <String>['Platinum', 'Gold', 'Silver', 'Kecubung']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
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
          labelText: 'Type of Member',
          labelStyle: AppStyles.bodyText,
          filled: true,
        ),
      ),
    );
  }
}
