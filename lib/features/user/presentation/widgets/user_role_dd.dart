import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';
import 'package:project_nineties/features/user/presentation/cubit/user_validator_cubit.dart';

class UserRoleDd extends StatelessWidget {
  const UserRoleDd({
    super.key,
    required this.initialValue,
    this.dropDownType,
  });

  final String initialValue;
  final DropDownType? dropDownType;
  @override
  Widget build(BuildContext context) {
    String selectedRole = initialValue;
    final userValidatorBloc = context.read<UserValidatorBloc>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        onChanged: (newValue) {
          final userValidatorState = userValidatorBloc.state.params;
          final userValidatorCubit = context.read<UserValidatorCubit>();

          if (newValue != null) {
            selectedRole = newValue;
            dropDownType == DropDownType.update
                ? userValidatorCubit.updateRole(role: selectedRole)
                : userValidatorBloc.add(UserValidatorForm(
                    params: userValidatorState.copyWith(roleId: selectedRole)));
          }
        },
        items: <String>['Admin', 'User', 'Superadmin']
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
          labelText: 'Role',
          labelStyle: AppStyles.bodyText,
          filled: true,
        ),
      ),
    );
  }
}
