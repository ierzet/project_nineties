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
  const PartnerLoadSuccess(this.message);

  @override
  List<Object> get props => [];
}

final class PartnerLoadFailure extends PartnerState {
  final String message;

  const PartnerLoadFailure(this.message);
  @override
  List<Object> get props => [];
}
