import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

class PartnerJoinDateCubit extends Cubit<DateTime> {
  PartnerJoinDateCubit() : super(DateTime.now());

  void onJoinDateChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 2);
    final DateTime lastDate = DateTime(DateTime.now().year + 1);

    // Simpan PartnerValidatorBloc sebelum async gap
    final partnerValidatorBloc = context.read<PartnerValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      final partnerParams = partnerValidatorBloc.state.partnerParams;
      partnerValidatorBloc.add(PartnerValidatorForm(
          partnerParams: partnerParams.copyWith(partnerJoinDate: date)));
      emit(date);
    }
  }
}
