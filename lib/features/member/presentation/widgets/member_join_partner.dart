import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';

class MemberPartnerDd extends StatelessWidget {
  const MemberPartnerDd({
    super.key,
    this.initialValue,
    this.dropDownType,
  });

  final String? initialValue;
  final DropDownType? dropDownType;

  @override
  Widget build(BuildContext context) {
    final memberValidatorBloc = context.read<MemberValidatorBloc>();
    // print(initialValue);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
      child: BlocBuilder<PartnerBloc, PartnerState>(
        builder: (context, state) {
          if (state is PartnerLoadDataSuccess) {
            // print(initialValue);
            String selectedPartnerId =
                (initialValue == null || initialValue!.isEmpty)
                    ? state.data.first.partnerId
                    : initialValue!;

            return DropdownButtonFormField<String>(
              value: selectedPartnerId,
              onChanged: (newValue) {
                // print('onChanged: $newValue');
                final memberValidatorState = memberValidatorBloc.state.data;

                if (newValue != null) {
                  // Update the selected partner ID
                  selectedPartnerId = newValue;

                  // Find the selected partner based on the new value
                  final selectedPartner = state.data.firstWhere(
                      (partner) => partner.partnerId == selectedPartnerId);

                  // Update the state based on the dropdown type
                  if (dropDownType == DropDownType.update) {
                    // Directly update the memberValidatorState
                    memberValidatorBloc.add(MemberValidatorForm(
                      params: memberValidatorState.copyWith(
                        memberJoinPartner: selectedPartner,
                      ),
                    ));
                  } else {
                    // For registration or other types
                    memberValidatorBloc.add(MemberValidatorForm(
                      params: memberValidatorState.copyWith(
                        memberJoinPartner: selectedPartner,
                      ),
                    ));
                  }
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
