import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberDropdownSelector extends StatelessWidget {
  const MemberDropdownSelector(
      {super.key,
      required this.initialValue,
      required this.items,
      required this.label,
      required this.type, // Added type to identify the dropdown type
      this.isEnabled});

  final String initialValue;
  final List<String> items;
  final String label;
  final String type; // New parameter to identify the dropdown type
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: DropdownButtonFormField<String>(
        value: initialValue,
        onChanged: (newValue) {
          final memberValidatorBloc = context.read<MemberValidatorBloc>();
          final memberValidatorState = memberValidatorBloc.state.data;

          if (newValue != null) {
            switch (type) {
              case 'gender':
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberGender: newValue,
                  ),
                ));
                break;
              case 'memberType':
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberTypeOfMember: newValue,
                  ),
                ));
                break;
              case 'vehicleBrand':
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberBrandOfVehicle: newValue,
                  ),
                ));
                break;
              case 'vehicleType':
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberTypeOfVehicle: newValue,
                  ),
                ));
                break;
              case 'vehicleSize':
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberSizeOfVehicle: newValue,
                  ),
                ));
                break;
              case 'status':
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberStatusMember: newValue == 'Active',
                  ),
                ));
                break;
              case 'year': // New case for year selection
                memberValidatorBloc.add(MemberValidatorForm(
                  params: memberValidatorState.copyWith(
                    memberYearOfVehicle: int.tryParse(newValue),
                  ),
                ));
                break;
            }
          }
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            enabled: isEnabled ?? true,
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
          labelText: label,
          labelStyle: AppStyles.bodyText,
          filled: true,
        ),
      ),
    );
  }
}
