import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberDOBDateCubit extends Cubit<DateTime> {
  MemberDOBDateCubit() : super(DateTime(DateTime.now().year - 10));

  void onDOBDateChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 80);
    final DateTime lastDate = DateTime(DateTime.now().year - 10);

    // Simpan MemberValidatorBloc sebelum async gap
    final memberValidatorBloc = context.read<MemberValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      final memberParams = memberValidatorBloc.state.data;
      memberValidatorBloc.add(MemberValidatorForm(
          params: memberParams.copyWith(memberDateOfBirth: date)));
      emit(date);
    }
  }

  void onInitialDate(DateTime date) {
    emit(date);
  }
}
