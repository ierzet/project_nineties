import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';

class CustomerExpiredDateCubit extends Cubit<DateTime> {
  CustomerExpiredDateCubit() : super(DateTime.now());

  void onExpiredDateChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 0);
    final DateTime lastDate = DateTime(DateTime.now().year + 2);

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
}
