part of 'member_bloc.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object> get props => [];
}

class MemberRegister extends MemberEvent {
  const MemberRegister({required this.params, required this.context});

  final MemberEntity params;
  final BuildContext context;
  @override
  List<Object> get props => [params, context];
}

class MemberUpdateData extends MemberEvent {
  const MemberUpdateData({required this.params, required this.context});

  final MemberEntity params;
  final BuildContext context;
  @override
  List<Object> get props => [params, context];
}

class MemberGetData extends MemberEvent {
  final int limit;

  const MemberGetData({this.limit = 10});

  @override
  List<Object> get props => [limit];
}

class MemberSubscriptionSuccsess extends MemberEvent {
  const MemberSubscriptionSuccsess({required this.params});

  final List<MemberEntity> params;
  @override
  List<Object> get props => [params];
}

class MemberSubscriptionFailure extends MemberEvent {
  const MemberSubscriptionFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class MemberSearchEvent extends MemberEvent {
  final String query;

  const MemberSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

class MemberExportToExcel extends MemberEvent {
  const MemberExportToExcel({required this.param});
  final List<MemberEntity> param;

  @override
  List<Object> get props => [param];
}

class MemberExportToCSV extends MemberEvent {
  const MemberExportToCSV({required this.param});

  final List<MemberEntity> param;
  @override
  List<Object> get props => [param];
}

class MemberExtend extends MemberEvent {
  final MemberEntity params;
  final BuildContext context;

  const MemberExtend({
    required this.params,
    required this.context,
  });

  @override
  List<Object> get props => [params, context];
}

class MemberLoadMoreData extends MemberEvent {
  final int limit;

  const MemberLoadMoreData({this.limit = 10});

  @override
  List<Object> get props => [limit];
}

class MemberStreamUpdate extends MemberEvent {
  final List<MemberEntity> data;

  const MemberStreamUpdate({required this.data});

  @override
  List<Object> get props => [data];
}
