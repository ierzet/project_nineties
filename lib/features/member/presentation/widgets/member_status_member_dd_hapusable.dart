// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_nineties/core/utilities/constants.dart';
// import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

// class MemberStatusMemberDd extends StatelessWidget {
//   const MemberStatusMemberDd({super.key, required this.initialValue});

//   final bool initialValue;
//   @override
//   Widget build(BuildContext context) {
//     bool selectedStatusMember = initialValue;
//     final memberValidatorBloc = context.read<MemberValidatorBloc>();

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
//       child: DropdownButtonFormField<bool>(
//         value: selectedStatusMember,
//         onChanged: (newValue) {
//           final memberValidatorState = memberValidatorBloc.state.data;
//           if (newValue != null) {
//             selectedStatusMember = newValue;
//             memberValidatorBloc.add(MemberValidatorForm(
//                 params: memberValidatorState.copyWith(
//                     memberStatusMember: selectedStatusMember)));
//           }
//         },
//         items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
//           return DropdownMenuItem<bool>(
//             value: value,
//             child: Text(value ? 'Active' : 'InActive'),
//           );
//         }).toList(),
//         decoration: InputDecoration(
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(),
//           ),
//           errorBorder: const OutlineInputBorder(
//             borderSide: BorderSide(),
//           ),
//           labelText: 'Status Member',
//           labelStyle: AppStyles.bodyText,
//           filled: true,
//         ),
//       ),
//     );
//   }
// }
