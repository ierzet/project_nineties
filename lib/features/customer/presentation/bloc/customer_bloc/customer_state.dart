part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {
  const CustomerInitial();
  @override
  List<Object> get props => [];
}

class CustomerLoadInProgress extends CustomerState {
  const CustomerLoadInProgress();
  @override
  List<Object> get props => [];
}

class CustomerLoadSuccess extends CustomerState {
  const CustomerLoadSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class CustomerLoadUpdateSuccess extends CustomerState {
  const CustomerLoadUpdateSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class CustomerLoadFailure extends CustomerState {
  const CustomerLoadFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class CustomerLoadDataSuccess extends CustomerState {
  const CustomerLoadDataSuccess({required this.data});

  final List<CustomerEntity> data;
  @override
  List<Object> get props => [data];
}
