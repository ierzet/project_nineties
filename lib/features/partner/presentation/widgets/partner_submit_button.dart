import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

class PartnerSubmitButton extends StatelessWidget {
  const PartnerSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      final partnerParams =
          context.read<PartnerValidatorBloc>().state.partnerParams;
      context.read<PartnerBloc>().add(AdminRegPartnerClicked(
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
                  ? const CircularProgressIndicator(
                      // color: AppColors.background,
                      )
                  : Text(
                      'Submit',
                      style: AppStyles.buttonText,
                    );
            },
          ),
        ),
      ),
    );
  }
}
