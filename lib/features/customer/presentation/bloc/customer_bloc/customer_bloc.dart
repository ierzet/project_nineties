import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/customer/domain/usecases/customer_usecase.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:rxdart/rxdart.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc({required this.useCase}) : super(const CustomerInitial()) {
    on<CustomerRegister>(_onCustomerRegister,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<CustomerGetData>(_onCustomerGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<CustomerUpdateData>(_onCustomerUpdateData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<CustomerSubscriptionSuccsess>(_onCustomerSubscriptionSuccsess,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<CustomerSubscriptionFailure>(_onCustomerSubscriptionFailure,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<CustomerSearchEvent>(_onCustomerSearchEvent,
        transformer: debounce(const Duration(milliseconds: 500)));

    _customerSubscription = useCase().listen((result) {
      result.fold(
        (failure) => add(CustomerSubscriptionFailure(message: failure.message)),
        (data) => add(CustomerSubscriptionSuccsess(params: data)),
      );
    });
  }

  final CustomerUseCase useCase;
  late final StreamSubscription _customerSubscription;
  List<CustomerEntity> _originalData = []; // Store original data

  void _onCustomerSubscriptionSuccsess(
      CustomerSubscriptionSuccsess event, Emitter<CustomerState> emit) async {
    _originalData = event.params; // Store original data
    emit(CustomerLoadDataSuccess(data: event.params));
  }

  void _onCustomerSubscriptionFailure(
      CustomerSubscriptionFailure event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadFailure(message: event.message));
  }

  void _onCustomerRegister(
      CustomerRegister event, Emitter<CustomerState> emit) async {
    emit(const CustomerLoadInProgress());

    if (!event.params.isValid) {
      emit(const CustomerLoadFailure(message: AppStrings.dataIsNotValid));
      return;
    }
    final navigatorBloc = event.context.read<NavigationCubit>();
    final customerValidatorBloc = event.context.read<CustomerValidatorBloc>();
    final result = await useCase.insertData(event.params);
    result.fold(
      (failure) {
        emit(CustomerLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        customerValidatorBloc
            .add(CustomerClearValidator(context: event.context));
        navigatorBloc.updateIndex(0);
        emit(CustomerLoadSuccess(message: data));
      },
    );
  }

  void _onCustomerGetData(
      CustomerGetData event, Emitter<CustomerState> emit) async {
    emit(const CustomerLoadInProgress());

    final result = await useCase.fetchData();
    result.fold(
      (failure) {
        emit(CustomerLoadFailure(message: failure.message));
      },
      (data) {
        _originalData = data; // Store original data
        emit(CustomerLoadDataSuccess(data: data));
      },
    );
  }

  void _onCustomerUpdateData(
      CustomerUpdateData event, Emitter<CustomerState> emit) async {
    emit(const CustomerLoadInProgress());

    if (!event.params.isValid) {
      emit(const CustomerLoadFailure(message: AppStrings.dataIsNotValid));
      return;
    }
    final navigatorBloc = event.context.read<NavigationCubit>();
    final result = await useCase.updateData(event.params);
    result.fold(
      (failure) {
        emit(CustomerLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        navigatorBloc.updateSubMenu('customers_view');
        emit(CustomerLoadUpdateSuccess(message: data));
      },
    );
  }

  void _onCustomerSearchEvent(
      CustomerSearchEvent event, Emitter<CustomerState> emit) async {
    final filteredCustomers = _originalData.where((customer) {
      final name = customer.customerName?.toLowerCase() ??
          ''; // Handle nullable customerName
      return name.contains(event.query.toLowerCase());
    }).toList();
    emit(CustomerLoadDataSuccess(data: filteredCustomers));
  }

  @override
  Future<void> close() {
    _customerSubscription.cancel();
    return super.close();
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
