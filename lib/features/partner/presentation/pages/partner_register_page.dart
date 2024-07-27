import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/partner/presentation/cubit/partner_join_date_cubit.dart';
import 'package:project_nineties/features/partner/presentation/widgets/listener_notify_partner.dart';
import 'package:project_nineties/features/partner/presentation/widgets/partner_avatar_picker.dart';
import 'package:project_nineties/features/partner/presentation/widgets/partner_custom_textfield.dart';
import 'package:project_nineties/features/partner/presentation/widgets/partner_submit_button.dart';
import 'package:intl/intl.dart';

class PartnerRegistrationPage extends StatelessWidget {
  const PartnerRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController joinDateController = TextEditingController();

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      //backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppPadding.defaultPadding.h),
              const PartnerAvatarPicker(), // Ensure this is styled well
              SizedBox(height: AppPadding.defaultPadding.h),
              Text(
                'Register as a Partner',
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
              const PartnerSubmitButton(type: 'register'),
              SizedBox(height: AppPadding.triplePadding),
              const ListenerNotificationPartner(),
            ],
          ),
        ),
      ),
    );
  }
}
