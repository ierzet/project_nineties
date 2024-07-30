part of 'partner_bloc.dart';

sealed class PartnerState extends Equatable {
  const PartnerState();

  @override
  List<Object> get props => [];
}

final class PartnerInitial extends PartnerState {
  const PartnerInitial();
  @override
  List<Object> get props => [];
}

final class PartnerLoadInProgress extends PartnerState {
  const PartnerLoadInProgress();
  @override
  List<Object> get props => [];
}

final class PartnerLoadSuccess extends PartnerState {
  final String message;
  const PartnerLoadSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class PartnerLoadUpdateSuccess extends PartnerState {
  final String message;
  const PartnerLoadUpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class PartnerLoadFailure extends PartnerState {
  final String message;

  const PartnerLoadFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class PartnerLoadDataSuccess extends PartnerState {
  final List<PartnerEntity> data;
  const PartnerLoadDataSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
