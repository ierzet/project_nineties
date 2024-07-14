part of 'customer_validator_bloc.dart';

sealed class CustomerValidatorBlocEvent extends Equatable {
  const CustomerValidatorBlocEvent();

  @override
  List<Object> get props => [];
}

class CustomerValidatorForm extends CustomerValidatorBlocEvent {
  const CustomerValidatorForm({
    required this.params,
  });

  final CustomerEntity params;
  @override
  List<Object> get props => [params];
}

class CustomerClearValidator extends CustomerValidatorBlocEvent {
  const CustomerClearValidator({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [context];
}
