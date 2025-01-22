part of 'member_bloc.dart';

abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object> get props => [];
}

class MemberInitial extends MemberState {
  const MemberInitial();
  @override
  List<Object> get props => [];
}

class MemberLoadInProgress extends MemberState {
  const MemberLoadInProgress();
  @override
  List<Object> get props => [];
}

class MemberLoadSuccess extends MemberState {
  const MemberLoadSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class MemberLoadToExcelSuccess extends MemberState {
  const MemberLoadToExcelSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class MemberLoadUpdateSuccess extends MemberState {
  const MemberLoadUpdateSuccess({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class MemberLoadFailure extends MemberState {
  const MemberLoadFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}

class MemberLoadDataSuccess extends MemberState {
  const MemberLoadDataSuccess({
    required this.data,
    this.lastDoc,
  });

  final List<MemberEntity> data;
  final DocumentSnapshot? lastDoc;

  @override
  List<Object> get props => [
        data,
        lastDoc ?? '',
      ];
}

class MemberLoadMoreInProgress extends MemberState {
  const MemberLoadMoreInProgress();
  @override
  List<Object> get props => [];
}
