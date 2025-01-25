import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

class PartnerSubmitButton extends StatelessWidget {
  const PartnerSubmitButton({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      final partnerParams =
          context.read<PartnerValidatorBloc>().state.partnerParams;

      type == 'register'
          ? context.read<PartnerBloc>().add(PartnerRegister(
                context: context,
                params: partnerParams,
              ))
          : context.read<PartnerBloc>().add(PartnerUpdateData(
                context: context,
                params: partnerParams,
              ));
      context
          .read<PartnerValidatorBloc>()
          .add(PartnerClearValidator(context: context));
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
          child: BlocBuilder<PartnerBloc, PartnerState>(
            builder: (context, state) {
              return state is PartnerLoadInProgress
                  // ? const CircularProgressIndicator(
                  //     // color: AppColors.background,
                  //     )
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
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
