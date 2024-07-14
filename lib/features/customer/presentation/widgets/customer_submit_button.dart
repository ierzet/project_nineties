import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';

class CustomerSubmitButton extends StatelessWidget {
  const CustomerSubmitButton({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      final customerParams = context.read<CustomerValidatorBloc>().state.data;

      type == 'register'
          ? context.read<CustomerBloc>().add(CustomerRegister(
                context: context,
                params: customerParams,
              ))
          : context.read<CustomerBloc>().add(CustomerUpdateData(
                context: context,
                params: customerParams,
              ));
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
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              return state is CustomerLoadInProgress
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
