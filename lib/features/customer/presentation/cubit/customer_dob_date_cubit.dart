import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';

class CustomerDOBDateCubit extends Cubit<DateTime> {
  CustomerDOBDateCubit() : super(DateTime(DateTime.now().year - 10));

  void onDOBDateChanged(BuildContext context) async {
    DateTime? selectedDate;
    final DateTime firstDate = DateTime(DateTime.now().year - 80);
    final DateTime lastDate = DateTime(DateTime.now().year - 10);

    // Simpan CustomerValidatorBloc sebelum async gap
    final customerValidatorBloc = context.read<CustomerValidatorBloc>();

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? lastDate,
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
}
