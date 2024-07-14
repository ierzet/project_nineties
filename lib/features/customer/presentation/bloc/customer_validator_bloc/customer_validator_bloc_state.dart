part of 'customer_validator_bloc.dart';

class CustomerValidatorBlocState extends Equatable {
  const CustomerValidatorBlocState({required this.data});

  final CustomerEntity data;

  static final empty = CustomerValidatorBlocState(
    data: CustomerEntity.empty,
  );
  @override
  List<Object> get props => [data];
}
