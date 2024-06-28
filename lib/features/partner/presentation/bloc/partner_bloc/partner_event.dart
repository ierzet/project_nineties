part of 'partner_bloc.dart';

sealed class PartnerEvent extends Equatable {
  const PartnerEvent();

  @override
  List<Object> get props => [];
}

final class AdminRegPartnerClicked extends PartnerEvent {
  final PartnerParams params;

  const AdminRegPartnerClicked({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}
