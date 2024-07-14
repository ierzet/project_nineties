import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';

class CustomerJoinDateCubit extends Cubit<DateTime> {
  CustomerJoinDateCubit() : super(DateTime.now());

  void onJoinDateChanged(BuildContext context) async {
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
}
