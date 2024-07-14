import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';

class UserPartnerDd extends StatelessWidget {
  const UserPartnerDd({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final userValidatorBloc = context.read<UserValidatorBloc>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: BlocBuilder<PartnerBloc, PartnerState>(
        builder: (context, state) {
          if (state is PartnerLoadDataSuccess) {
            String selectedPartnerId =
                initialValue ?? state.data.first.partnerId;
            return DropdownButtonFormField<String>(
              value: selectedPartnerId,
              onChanged: (newValue) {
                final userValidatorState = userValidatorBloc.state.params;
                if (newValue != null) {
                  selectedPartnerId = newValue;
                  final selectedPartner = state.data.firstWhere(
                      (partner) => partner.partnerId == selectedPartnerId);
                  userValidatorBloc.add(UserValidatorForm(
                      params: userValidatorState.copyWith(
                          partner: selectedPartner)));
                }
              },
              items: state.data.map<DropdownMenuItem<String>>((partner) {
                return DropdownMenuItem<String>(
                  value: partner.partnerId,
                  child: Text(partner.partnerName ?? ''),
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
                labelText: 'Partner',
                labelStyle: AppStyles.bodyText,
                filled: true,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
