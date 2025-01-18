import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';

class MemberJoinDateCubit extends Cubit<DateTime> {
  MemberJoinDateCubit() : super(DateTime.now());

  void onJoinDateChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 2);
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
          params: memberParams.copyWith(memberJoinDate: date)));
      emit(date);
    }
  }

  void onInitialDate(DateTime date) {
    emit(date);
  }
}
