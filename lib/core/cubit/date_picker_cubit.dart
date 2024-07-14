import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';

class DatePickerCubit extends Cubit<DateTime> {
  DatePickerCubit() : super(DateTime.now());

  void onJoinDateCustomerChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 2);
    final DateTime lastDate = DateTime(DateTime.now().year + 1);

    // Simpan CustomerValidatorBloc sebelum async gap
    final customerValidatorBloc = context.read<CustomerValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      final customerParams = customerValidatorBloc.state.data;
      customerValidatorBloc.add(CustomerValidatorForm(
          params: customerParams.copyWith(customerJoinDate: date)));
      emit(date);
    }
  }

  void onBODateCustomerChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 2);
    final DateTime lastDate = DateTime(DateTime.now().year + 1);

    // Simpan CustomerValidatorBloc sebelum async gap
    final customerValidatorBloc = context.read<CustomerValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      final customerParams = customerValidatorBloc.state.data;
      customerValidatorBloc.add(CustomerValidatorForm(
          params: customerParams.copyWith(customerDateOfBirth: date)));
      emit(date);
    }
  }

  void onExpiredDateCustomerChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 2);
    final DateTime lastDate = DateTime(DateTime.now().year + 1);

    // Simpan CustomerValidatorBloc sebelum async gap
    final customerValidatorBloc = context.read<CustomerValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      final customerParams = customerValidatorBloc.state.data;
      customerValidatorBloc.add(CustomerValidatorForm(
          params: customerParams.copyWith(customerExpiredDate: date)));
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
