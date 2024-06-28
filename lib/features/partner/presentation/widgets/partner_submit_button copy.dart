// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_nineties/core/utilities/constants.dart';
// import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
// import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc.dart';
// import 'package:project_nineties/features/partner/presentation/bloc/validator/partner_validator_bloc.dart';
// import 'package:project_nineties/features/partner/presentation/cubit/partner_join_date_cubit.dart';

// class PartnerSubmitButton extends StatelessWidget {
//   const PartnerSubmitButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // const gradient = LinearGradient(
//     //   colors: [AppColors.accent, AppColors.primary],
//     //   begin: Alignment.topLeft,
//     //   end: Alignment.bottomRight,
//     // );
//     void onTap() {
//       final currentState =
//           context.read<PartnerValidatorBloc>().state.partnerParams;
//       final currentUser = context.read<AppBloc>().state.user;
//       final currentJoinDate = context.read<PartnerJoinDateCubit>().state;
// // partnerParams: currentState.copyWith(
// //             partnerStatus: 'active',
// //             partnerJoinDate: currentJoinDate,
// //             partnerCreatedBy: currentUser.id,
// //             partnerCreatedDate: DateTime.now(),
// //             partnerIsDeleted: false,
//       // context.read<PartnerValidatorBloc>().add(PartnerValidatorBlocEvent(
//       //         partnerParams: currentState.copyWith(
//       //       partnerStatus: 'active',
//       //       partnerJoinDate: currentJoinDate,
//       //       partnerCreatedBy: currentUser.id,
//       //       partnerCreatedDate: DateTime.now(),
//       //       partnerIsDeleted: false,
//       //     )));
//       context.read<PartnerValidatorBloc>().add(PartnerValidatorBlocEvent(
//               partnerParams: currentState.copyWith(
//             partnerStatus: 'active',
//             partnerJoinDate: currentJoinDate,
//             partnerCreatedBy: currentUser.id,
//             partnerCreatedDate: DateTime.now(),
//             partnerIsDeleted: false,
//           )));
//       final stateUpdated =
//           context.read<PartnerValidatorBloc>().state.partnerParams;
//       print('button: $stateUpdated');
//       context
//           .read<PartnerBloc>()
//           .add(AdminRegPartnerClicked(params: stateUpdated));
//     }

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppPadding.defaultPadding.r),
//           ),
//           elevation: AppPadding.halfPadding.r / 2,
//           // Add your gradient background here if needed
//           // primary: AppColors.primary, // Set primary color if needed
//         ),
//         child: Center(
//           child: BlocBuilder<PartnerBloc, PartnerState>(
//             builder: (context, state) {
//               return state is PartnerLoadInProgress
//                   ? const CircularProgressIndicator(
//                       // color: AppColors.background,
//                       )
//                   : Text(
//                       'Submit',
//                       style: AppStyles.buttonText,
//                     );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
