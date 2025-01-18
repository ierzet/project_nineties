import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberRegistrationDateCubit extends Cubit<DateTime> {
  MemberRegistrationDateCubit() : super(DateTime.now());

  void onRegistrationChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 1);
    final DateTime lastDate = DateTime(DateTime.now().year + 1);

    // Simpan MemberValidatorBloc sebelum async gap
    final memberValidatorBloc = context.read<MemberValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      final memberParams = memberValidatorBloc.state.data;
      memberValidatorBloc.add(MemberValidatorForm(
          params: memberParams.copyWith(memberRegistrationDate: date)));
      emit(date);
    }
  }
}
