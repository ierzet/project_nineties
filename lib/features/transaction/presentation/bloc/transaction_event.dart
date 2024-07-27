part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetCustomerInformationCard extends TransactionEvent {
  const GetCustomerInformationCard({required this.param});

  final String param;

  @override
  List<Object> get props => [param];
}

class AddTransaction extends TransactionEvent {
  const AddTransaction({
    required this.customerEntity,
    required this.userAccountEntity,
  });

  final CustomerEntity customerEntity;
  final UserAccountEntity userAccountEntity;

  @override
  List<Object> get props => [customerEntity, userAccountEntity];
}

class TransactionGetData extends TransactionEvent {
  const TransactionGetData();

  @override
  List<Object> get props => [];
}

class TransactionSubscriptionSuccsess extends TransactionEvent {
  const TransactionSubscriptionSuccsess({required this.params});

  final List<TransactionEntity> params;
  @override
  List<Object> get props => [params];
}

class TransactionSubscriptionFailure extends TransactionEvent {
  const TransactionSubscriptionFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}