import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_dob_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_expired_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_join_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_step_cubit.dart';
import 'package:project_nineties/features/customer/presentation/widgets/customer_custom_texfield.dart';
import 'package:project_nineties/features/customer/presentation/widgets/customer_gender_dd.dart';
import 'package:project_nineties/features/customer/presentation/widgets/customer_member_type_dd.dart';
import 'package:project_nineties/features/customer/presentation/widgets/customer_status_member_dd.dart';
import 'package:project_nineties/features/customer/presentation/widgets/customer_submit_button.dart';
import 'package:project_nineties/features/customer/presentation/widgets/listener_notify_customer.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';

class CustomerUpdatePage extends StatelessWidget {
  const CustomerUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final customerState = context.read<CustomerValidatorBloc>().state.data;
    final TextEditingController nameController =
        TextEditingController(text: customerState.customerName);
    final TextEditingController emailController =
        TextEditingController(text: customerState.customerEmail);
    final TextEditingController phoneController =
        TextEditingController(text: customerState.customerPhoneNumber);
    final TextEditingController dobController = TextEditingController(
        text: customerState.customerDateOfBirth != null
            ? DateFormat('dd MMM yyyy')
                .format(customerState.customerDateOfBirth!)
            : '');
    final TextEditingController vehicleNoController =
        TextEditingController(text: customerState.customerNoVehicle);
    final TextEditingController vehicleTypeController =
        TextEditingController(text: customerState.customerTypeOfVehicle);
    final TextEditingController vehicleColorController =
        TextEditingController(text: customerState.customerColorOfVehicle);
    final TextEditingController joinDateController = TextEditingController(
        text: customerState.customerJoinDate != null
            ? DateFormat('dd MMM yyyy').format(customerState.customerJoinDate!)
            : '');
    final TextEditingController expiredDateController = TextEditingController(
        text: customerState.customerExpiredDate != null
            ? DateFormat('dd MMM yyyy')
                .format(customerState.customerExpiredDate!)
            : '');

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: SingleChildScrollView(
        child: BlocBuilder<CustomerStepCubit, int>(
          builder: (context, currentStep) {
            return Stepper(
              currentStep: currentStep,
              onStepTapped: (step) =>
                  context.read<CustomerStepCubit>().goToStep(step),
              onStepContinue: () {
                if (currentStep < 2) {
                  context.read<CustomerStepCubit>().nextStep();
                } else {
                  // Handle form submission for update
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => context.read<CustomerStepCubit>().previousStep(),
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                return currentStep == 2
                    ? const SizedBox.shrink()
                    : Container(
                        margin:
                            EdgeInsets.only(top: AppPadding.doublePadding.h),
                        child: Row(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: controls.onStepContinue,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Theme.of(context).colorScheme.primary),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                    TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary)),
                                padding:
                                    WidgetStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0)),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0))),
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                            ),
                            SizedBox(width: AppPadding.halfPadding.w / 2),
                            TextButton(
                              onPressed: controls.onStepCancel,
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Theme.of(context).colorScheme.secondary),
                                padding:
                                    WidgetStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0)),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0))),
                              ),
                              child: const Text('Back'),
                            ),
                          ],
                        ),
                      );
              },
              steps: [
                Step(
                  title: const Text('Personal Information'),
                  content: Column(
                    children: [
                      SizedBox(height: AppPadding.halfPadding.h / 2),
                      CustomerCustomTextField(
                        controller: nameController,
                        type: InputType.name,
                        label: 'Name',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      CustomerCustomTextField(
                        controller: emailController,
                        type: InputType.email,
                        label: 'Email',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      CustomerCustomTextField(
                        controller: phoneController,
                        type: InputType.phone,
                        label: 'Phone Number',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      CustomerGenderDd(
                          initialValue: customerState.customerGender ??
                              'Male'), // Consider pre-selecting the value based on the customer data
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<CustomerDOBDateCubit, DateTime>(
                        builder: (context, state) {
                          return CustomerCustomTextField(
                            controller: dobController,
                            type: InputType.dOBDate,
                            label: 'Date of Birth',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Vehicle Information'),
                  content: Column(
                    children: [
                      SizedBox(height: AppPadding.halfPadding.h / 2),
                      CustomerCustomTextField(
                        controller: vehicleNoController,
                        type: InputType.vehicleNo,
                        label: 'Vehicle Number',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      CustomerCustomTextField(
                        controller: vehicleTypeController,
                        type: InputType.vehicleType,
                        label: 'Type of Vehicle',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      CustomerCustomTextField(
                        controller: vehicleColorController,
                        type: InputType.vehicleColor,
                        label: 'Color of Vehicle',
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Membership Information'),
                  content: Column(
                    children: [
                      SizedBox(height: AppPadding.halfPadding.h / 2),
                      CustomerTypeOfMemberDd(
                          initialValue:
                              customerState.customerTypeOfMember ?? 'Platinum'),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      CustomerStatusMemberDd(
                        initialValue:
                            customerState.customerStatusMember ?? true,
                      ), // Consider pre-selecting the value based on the customer data
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<CustomerJoinDateCubit, DateTime>(
                        builder: (context, state) {
                          return CustomerCustomTextField(
                            controller: joinDateController,
                            type: InputType.joinDate,
                            label: 'Join Date',
                          );
                        },
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<CustomerExpiredDateCubit, DateTime>(
                        builder: (context, state) {
                          return CustomerCustomTextField(
                            controller: expiredDateController,
                            type: InputType.expiredDate,
                            label: 'Expired Date',
                          );
                        },
                      ),
                      SizedBox(height: AppPadding.halfPadding.h * 3),
                      const CustomerSubmitButton(type: 'update'),
                      SizedBox(height: AppPadding.triplePadding),
                      const ListenerNotificationCustomer(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
