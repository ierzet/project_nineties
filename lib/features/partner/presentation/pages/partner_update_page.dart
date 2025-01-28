import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/cubit/partner_join_date_cubit.dart';
import 'package:project_nineties/features/partner/presentation/widgets/partner_avatar_picker.dart';
import 'package:project_nineties/features/partner/presentation/widgets/partner_custom_textfield.dart';
import 'package:project_nineties/features/partner/presentation/widgets/partner_submit_button.dart';

class PartnerUpdatePage extends StatelessWidget {
  const PartnerUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final partnerState =
        context.read<PartnerValidatorBloc>().state.partnerParams;
    final TextEditingController companyNameController =
        TextEditingController(text: partnerState.partnerName);
    final TextEditingController emailController =
        TextEditingController(text: partnerState.partnerEmail);
    final TextEditingController phoneController =
        TextEditingController(text: partnerState.partnerPhoneNumber);
    final TextEditingController addressController =
        TextEditingController(text: partnerState.partnerAddress);
    final TextEditingController joinDateController = TextEditingController(
      text: DateFormat('dd MMM yyyy').format(partnerState.partnerJoinDate),
    );

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      // backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.doublePadding.h),
              const PartnerAvatarPicker(), // Ensure this is styled well
              SizedBox(height: AppPadding.defaultPadding.h),
              Text(
                'Update Partner Details',
                style: AppStyles.header.copyWith(fontSize: 20),
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              PartnerCustomTextField(
                controller: companyNameController,
                type: InputType.name,
                label: 'Company name',
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              PartnerCustomTextField(
                controller: addressController,
                type: InputType.address,
                label: 'Company address',
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              PartnerCustomTextField(
                controller: emailController,
                type: InputType.email,
                label: 'Email',
              ),
              SizedBox(height: AppPadding.defaultPadding.h),
              PartnerCustomTextField(
                controller: phoneController,
                type: InputType.phone,
                label: 'Phone number',
              ),
              SizedBox(height: AppPadding.defaultPadding.h),

              BlocBuilder<PartnerJoinDateCubit, DateTime>(
                builder: (context, state) {
                  joinDateController.text =
                      DateFormat('dd MMM yyyy').format(state);
                  return PartnerCustomTextField(
                    controller: joinDateController,
                    type: InputType.date,
                    label: 'Join date',
                  );
                },
              ),
              SizedBox(height: AppPadding.halfPadding.h * 3),
              const PartnerSubmitButton(type: 'update'),
              SizedBox(height: AppPadding.triplePadding),
              //const ListenerNotificationPartner(),
            ],
          ),
        ),
      ),
    );
  }
}
