import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';

part 'customer_validator_bloc_event.dart';
part 'customer_validator_bloc_state.dart';

class CustomerValidatorBloc
    extends Bloc<CustomerValidatorBlocEvent, CustomerValidatorBlocState> {
  CustomerValidatorBloc() : super(CustomerValidatorBlocState.empty) {
    on<CustomerValidatorForm>(_onCustomerValidatorForm);
    on<CustomerClearValidator>(_onCustomerClearValidator);
  }

  void _onCustomerValidatorForm(CustomerValidatorForm event,
      Emitter<CustomerValidatorBlocState> emit) async {
    emit(CustomerValidatorBlocState(data: event.params));
  }

  void _onCustomerClearValidator(CustomerClearValidator event,
      Emitter<CustomerValidatorBlocState> emit) async {
    emit(CustomerValidatorBlocState.empty);
  }
}
