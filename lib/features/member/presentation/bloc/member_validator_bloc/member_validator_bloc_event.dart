part of 'member_validator_bloc.dart';

sealed class MemberValidatorBlocEvent extends Equatable {
  const MemberValidatorBlocEvent();

  @override
  List<Object> get props => [];
}

class MemberValidatorForm extends MemberValidatorBlocEvent {
  const MemberValidatorForm({
    required this.params,
  });

  final MemberEntity params;
  @override
  List<Object> get props => [params];
}

class MemberClearValidator extends MemberValidatorBlocEvent {
  const MemberClearValidator({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [context];
}
