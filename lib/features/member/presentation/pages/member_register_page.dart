import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_dob_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_expired_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_join_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_registration_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_step_cubit.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_custom_texfield.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_dd_selector.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_join_partner.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_submit_button.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_vehicle_image_picker.dart';

class MemberRegistrationPage extends StatelessWidget {
  const MemberRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController dobController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController vehicleNoController = TextEditingController();
    final TextEditingController vehicleColorController =
        TextEditingController();
    final TextEditingController joinDateController = TextEditingController();
    final TextEditingController expiredDateController = TextEditingController();
    final TextEditingController registrationDateController =
        TextEditingController();

    const initValueData = 'No Data';
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: SingleChildScrollView(
        child: BlocBuilder<MemberStepCubit, int>(
          builder: (context, currentStep) {
            return Stepper(
              currentStep: currentStep,
              onStepTapped: (step) =>
                  context.read<MemberStepCubit>().goToStep(step),
              onStepContinue: () {
                if (currentStep < 2) {
                  context.read<MemberStepCubit>().nextStep();
                } else {
                  // Handle form submission
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => context.read<MemberStepCubit>().previousStep(),
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
                      MemberCustomTextField(
                        controller: nameController,
                        type: InputType.name,
                        label: 'Name',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberCustomTextField(
                        controller: emailController,
                        type: InputType.email,
                        label: 'Email',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberCustomTextField(
                        controller: phoneController,
                        type: InputType.phone,
                        label: 'Phone Number',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberDropdownSelector(
                        initialValue: initValueData,
                        items: AppMasterList.masterListGender,
                        label: 'Select Gender',
                        type: 'gender', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberCustomTextField(
                        controller: addressController,
                        type: InputType.address,
                        label: 'Address',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<MemberDOBDateCubit, DateTime>(
                        builder: (context, state) {
                          dobController.text =
                              DateFormat('dd MMM yyyy').format(state);
                          return MemberCustomTextField(
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
                      const MemberVehicleImagePicker(
                        isEnabled: true,
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberDropdownSelector(
                        initialValue: DateTime.now().year.toString(),
                        items: AppMasterList.masterListYearOfVehicle,
                        label: 'Select Year',
                        type: 'year', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberCustomTextField(
                        controller: vehicleNoController,
                        type: InputType.vehicleNo,
                        label: 'Vehicle Number',
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberDropdownSelector(
                        initialValue: initValueData,
                        items: AppMasterList.masterListTypeOfVehicle,
                        label: 'Select Vehicle Type',
                        type: 'vehicleType', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberDropdownSelector(
                        initialValue: initValueData,
                        items: AppMasterList.masterListBrandOfVehicle,
                        label: 'Select Vehicle Brand',
                        type: 'vehicleBrand', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberDropdownSelector(
                        initialValue: initValueData,
                        items: AppMasterList.masterListSizeOfVehicle,
                        label: 'Select Vehicle Size',
                        type: 'vehicleSize', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberCustomTextField(
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
                      MemberDropdownSelector(
                        initialValue: initValueData,
                        items: AppMasterList.masterListTypeOfMember,
                        label: 'Select Member',
                        type: 'memberType', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      MemberDropdownSelector(
                        initialValue: 'Active',
                        items: AppMasterList.masterListStatusMember,
                        label: 'Select Status',
                        type: 'status', // Pass the type here
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<MemberRegistrationDateCubit, DateTime>(
                        builder: (context, state) {
                          registrationDateController.text =
                              DateFormat('dd MMM yyyy').format(state);
                          return MemberCustomTextField(
                            controller: registrationDateController,
                            type: InputType.registrationDate,
                            label: 'Registration Date',
                          );
                        },
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      const MemberPartnerDd(),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<MemberJoinDateCubit, DateTime>(
                        builder: (context, state) {
                          joinDateController.text =
                              DateFormat('dd MMM yyyy').format(state);
                          return MemberCustomTextField(
                            controller: joinDateController,
                            type: InputType.joinDate,
                            label: 'Join Date',
                          );
                        },
                      ),
                      SizedBox(height: AppPadding.defaultPadding.h),
                      BlocBuilder<MemberExpiredDateCubit, DateTime>(
                        builder: (context, state) {
                          expiredDateController.text =
                              DateFormat('dd MMM yyyy').format(state);
                          return MemberCustomTextField(
                            controller: expiredDateController,
                            type: InputType.expiredDate,
                            label: 'Expired Date',
                          );
                        },
                      ),
                      SizedBox(height: AppPadding.halfPadding.h * 3),
                      const MemberSubmitButton(type: 'register'),
                      SizedBox(height: AppPadding.triplePadding),
                      //const ListenerNotificationMember(),
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
