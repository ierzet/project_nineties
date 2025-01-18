// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_nineties/core/utilities/constants.dart';
// import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

// class MemberGenderDd extends StatelessWidget {
//   const MemberGenderDd({super.key, required this.initialValue});

//   final String initialValue;
//   @override
//   Widget build(BuildContext context) {
//     final memberValidatorBloc = context.read<MemberValidatorBloc>();
//     String selectedGender = initialValue;

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w * 3),
//       child: DropdownButtonFormField<String>(
//         value: selectedGender,
//         onChanged: (newValue) {
//           final memberValidatorState = memberValidatorBloc.state.data;
//           if (newValue != null) {
//             selectedGender = newValue;
//             memberValidatorBloc.add(MemberValidatorForm(
//                 params: memberValidatorState.copyWith(
//                     memberGender: selectedGender)));
//           }
//         },
//         items: <String>['Male', 'Female', 'Other']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
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
//           labelText: 'Gender',
//           labelStyle: AppStyles.bodyText,
//           filled: true,
//         ),
//       ),
//     );
//   }
// }
