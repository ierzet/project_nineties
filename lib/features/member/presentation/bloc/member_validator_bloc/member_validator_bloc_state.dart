part of 'member_validator_bloc.dart';

class MemberValidatorBlocState extends Equatable {
  const MemberValidatorBlocState({required this.data});

  final MemberEntity data;

  static final empty = MemberValidatorBlocState(
    data: MemberEntity.empty,
  );
  @override
  List<Object> get props => [data];
}
