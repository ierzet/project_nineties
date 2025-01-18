import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

class DatePickerCubit extends Cubit<DateTime> {
  DatePickerCubit() : super(DateTime.now());

  void onJoinDateMemberChanged(BuildContext context) async {
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

  void onBODateMemberChanged(BuildContext context) async {
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
          params: memberParams.copyWith(memberDateOfBirth: date)));
      emit(date);
    }
  }

  void onExpiredDateMemberChanged(BuildContext context) async {
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
          params: memberParams.copyWith(memberExpiredDate: date)));
      emit(date);
    }
  }

  void onJoinDatePartnerChanged(BuildContext context) async {
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
