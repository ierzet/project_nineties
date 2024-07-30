part of 'partner_bloc.dart';

sealed class PartnerEvent extends Equatable {
  const PartnerEvent();

  @override
  List<Object> get props => [];
}

class PartnerRegister extends PartnerEvent {
  final PartnerParams params;
  final BuildContext context;
  const PartnerRegister({
    required this.context,
    required this.params,
  });

  @override
  List<Object> get props => [context, params];
}

class PartnerUpdateData extends PartnerEvent {
  final PartnerParams params;
  final BuildContext context;
  const PartnerUpdateData({
    required this.context,
    required this.params,
  });

  @override
  List<Object> get props => [params];
}

class PartnerGetData extends PartnerEvent {
  const PartnerGetData();

  @override
  List<Object> get props => [];
}

class PartnerSubscriptionSuccsess extends PartnerEvent {
  const PartnerSubscriptionSuccsess({required this.params});

  final List<PartnerEntity> params;
  @override
  List<Object> get props => [params];
}

class PartnerSubscriptionFailure extends PartnerEvent {
  const PartnerSubscriptionFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class PartnerExportToExcel extends PartnerEvent {
  const PartnerExportToExcel({required this.param});
  final List<PartnerEntity> param;

  @override
  List<Object> get props => [param];
}

class PartnerExportToCSV extends PartnerEvent {
  const PartnerExportToCSV({required this.param});

  final List<PartnerEntity> param;
  @override
  List<Object> get props => [param];
}
