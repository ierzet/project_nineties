part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
  @override
  List<Object> get props => [];
}

class TransactionLoadInProgress extends TransactionState {
  const TransactionLoadInProgress();
  @override
  List<Object> get props => [];
}

class TransactionLoadSuccess extends TransactionState {
  const TransactionLoadSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class TransactionLoadCustomerSuccess extends TransactionState {
  const TransactionLoadCustomerSuccess({required this.data});

  final CustomerEntity data;
  @override
  List<Object> get props => [data];
}

class TransactionLoadAddedSuccess extends TransactionState {
  const TransactionLoadAddedSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class TransactionLoadFailure extends TransactionState {
  const TransactionLoadFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

final class TransactionLoadDataSuccess extends TransactionState {
  final List<TransactionEntity> data;
  const TransactionLoadDataSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
