part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class CustomerRegister extends CustomerEvent {
  const CustomerRegister({required this.params, required this.context});

  final CustomerEntity params;
  final BuildContext context;
  @override
  List<Object> get props => [params, context];
}

class CustomerUpdateData extends CustomerEvent {
  const CustomerUpdateData({required this.params, required this.context});

  final CustomerEntity params;
  final BuildContext context;
  @override
  List<Object> get props => [params, context];
}

class CustomerGetData extends CustomerEvent {
  const CustomerGetData();

  @override
  List<Object> get props => [];
}

class CustomerSubscriptionSuccsess extends CustomerEvent {
  const CustomerSubscriptionSuccsess({required this.params});

  final List<CustomerEntity> params;
  @override
  List<Object> get props => [params];
}

class CustomerSubscriptionFailure extends CustomerEvent {
  const CustomerSubscriptionFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
