part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends TransactionEvent {
  const InitialState();

  @override
  List<Object> get props => [];
}

class GetMemberInformationCard extends TransactionEvent {
  const GetMemberInformationCard({required this.param});

  final String param;

  @override
  List<Object> get props => [param];
}

class AddTransaction extends TransactionEvent {
  const AddTransaction({
    required this.memberEntity,
    required this.userAccountEntity,
  });

  final MemberEntity memberEntity;
  final UserAccountEntity userAccountEntity;

  @override
  List<Object> get props => [memberEntity, userAccountEntity];
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

class TransactionExportToExcel extends TransactionEvent {
  const TransactionExportToExcel({required this.param});
  final List<TransactionEntity> param;

  @override
  List<Object> get props => [param];
}

class TransactionExportToCSV extends TransactionEvent {
  const TransactionExportToCSV({required this.param});

  final List<TransactionEntity> param;
  @override
  List<Object> get props => [param];
}
