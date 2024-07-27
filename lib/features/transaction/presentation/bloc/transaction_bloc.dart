import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/customer/domain/entities/customer_entity.dart';
import 'package:project_nineties/features/transaction/domain/entities/transaction_entity.dart';
import 'package:project_nineties/features/transaction/domain/usecases/transaction_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.useCase}) : super(const TransactionInitial()) {
    on<GetCustomerInformationCard>(_onGetCustomerInformationCard,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<AddTransaction>(_onAddTransaction,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<TransactionGetData>(_onTransactionGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<TransactionSubscriptionSuccsess>(_onTransactionSubscriptionSuccsess,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<TransactionSubscriptionFailure>(_onTransactionSubscriptionFailure,
        transformer: debounce(const Duration(milliseconds: 500)));

    _transactionSubscription = useCase().listen((result) {
      result.fold(
        (failure) =>
            add(TransactionSubscriptionFailure(message: failure.message)),
        (data) => add(TransactionSubscriptionSuccsess(params: data)),
      );
    });
  }

  final TransactionUseCase useCase;
  late final StreamSubscription _transactionSubscription;

  void _onTransactionSubscriptionSuccsess(TransactionSubscriptionSuccsess event,
      Emitter<TransactionState> emit) async {
    emit(TransactionLoadDataSuccess(data: event.params));
  }

  void _onTransactionSubscriptionFailure(TransactionSubscriptionFailure event,
      Emitter<TransactionState> emit) async {
    emit(TransactionLoadFailure(message: event.message));
  }

  void _onTransactionGetData(
      TransactionGetData event, Emitter<TransactionState> emit) async {
    emit(const TransactionLoadInProgress());

    final result = await useCase.fetchData();
    result.fold(
      (failure) {
        emit(TransactionLoadFailure(message: failure.message));
      },
      (data) {
        emit(TransactionLoadDataSuccess(data: data));
      },
    );
  }

  void _onGetCustomerInformationCard(
      GetCustomerInformationCard event, Emitter<TransactionState> emit) async {
    emit(const TransactionLoadInProgress());

    final result = await useCase.getCustomer(event.param);
    result.fold(
      (failure) {
        emit(TransactionLoadFailure(message: failure.message));
      },
      (data) {
        emit(TransactionLoadCustomerSuccess(data: data));
      },
    );
  }

  void _onAddTransaction(
      AddTransaction event, Emitter<TransactionState> emit) async {
    emit(const TransactionLoadInProgress());

    final result = await useCase.addTransaction(
      customerEntity: event.customerEntity,
      userAccountEntity: event.userAccountEntity,
    );

    result.fold(
      (failure) {
        emit(TransactionLoadFailure(message: failure.message));
      },
      (data) {
        emit(TransactionLoadAddedSuccess(message: data));
      },
    );
  }

  @override
  Future<void> close() {
    _transactionSubscription.cancel();
    return super.close();
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
