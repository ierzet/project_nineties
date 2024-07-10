part of 'partner_bloc.dart';

sealed class PartnerEvent extends Equatable {
  const PartnerEvent();

  @override
  List<Object> get props => [];
}

class AdminRegPartnerClicked extends PartnerEvent {
  final PartnerParams params;
  final BuildContext context;
  const AdminRegPartnerClicked({
    required this.context,
    required this.params,
  });

  @override
  List<Object> get props => [context, params];
}

class PartnerGetData extends PartnerEvent {
  const PartnerGetData();

  @override
  List<Object> get props => [];
}
