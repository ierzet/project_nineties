import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/member/domain/usecases/member_usecase.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc({required this.useCase}) : super(const MemberInitial()) {
    on<MemberRegister>(_onMemberRegister,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberGetData>(_onMemberGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberUpdateData>(_onMemberUpdateData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberSubscriptionSuccsess>(_onMemberSubscriptionSuccsess,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberSubscriptionFailure>(_onMemberSubscriptionFailure,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberSearchEvent>(_onMemberSearchEvent,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<MemberExportToExcel>(_onMemberExportToExcel,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberExportToCSV>(_onMemberExportToCSV,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MemberExtend>(_onMemberExtend,
        transformer: debounce(const Duration(milliseconds: 500)));
    _memberSubscription = useCase().listen((result) {
      result.fold(
        (failure) => add(MemberSubscriptionFailure(message: failure.message)),
        (data) => add(MemberSubscriptionSuccsess(params: data)),
      );
    });
  }

  final MemberUseCase useCase;
  late final StreamSubscription _memberSubscription;
  List<MemberEntity> _originalData = []; // Store original data

  void _onMemberSubscriptionSuccsess(
      MemberSubscriptionSuccsess event, Emitter<MemberState> emit) async {
    _originalData = event.params; // Store original data
    emit(MemberLoadDataSuccess(data: event.params));
  }

  void _onMemberSubscriptionFailure(
      MemberSubscriptionFailure event, Emitter<MemberState> emit) async {
    emit(MemberLoadFailure(message: event.message));
  }

  void _onMemberRegister(
      MemberRegister event, Emitter<MemberState> emit) async {
    emit(const MemberLoadInProgress());

    // if (!event.params.isValid) {
    //   emit(MemberLoadFailure(message: '${AppStrings.dataIsNotValid} '));
    //   return;
    // }
    //print('bloc params: ${event.params.memberJoinPartner}');
    final errors = event.params.validateFields('register');
    if (errors.isNotEmpty) {
      emit(MemberLoadFailure(
          message:
              'Data is not valid: ${errors.entries.map((e) => '${e.key}: ${e.value}').join(', ')}'));
      return;
    }

    final clearFormValidatorBloc = event.context.read<MemberValidatorBloc>();

    final result = await useCase.insertData(event.params);
    result.fold(
      (failure) {
        emit(MemberLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        clearFormValidatorBloc
            .add(MemberClearValidator(context: event.context));
        Navigator.pop(event.context);
        emit(MemberLoadSuccess(message: data));
      },
    );
  }

  void _onMemberGetData(MemberGetData event, Emitter<MemberState> emit) async {
    emit(const MemberLoadInProgress());

    final result = await useCase.fetchData();
    result.fold(
      (failure) {
        emit(MemberLoadFailure(message: failure.message));
      },
      (data) {
        _originalData = data; // Store original data
        emit(MemberLoadDataSuccess(data: data));
      },
    );
  }

  void _onMemberUpdateData(
      MemberUpdateData event, Emitter<MemberState> emit) async {
    emit(const MemberLoadInProgress());

    final errors = event.params.validateFields('update');
    if (errors.isNotEmpty) {
      emit(MemberLoadFailure(
          message:
              'Data is not valid: ${errors.entries.map((e) => '${e.key}: ${e.value}').join(', ')}'));
      return;
    }

    final clearFormValidatorBloc = event.context.read<MemberValidatorBloc>();
    final result = await useCase.updateData(event.params);

    result.fold(
      (failure) {
        emit(MemberLoadFailure(message: failure.message));
      },
      (data) {
        //clearForm
        clearFormValidatorBloc
            .add(MemberClearValidator(context: event.context));

        //back to home
        Navigator.pop(event.context);

        emit(MemberLoadUpdateSuccess(message: data));
      },
    );
  }

  void _onMemberSearchEvent(
      MemberSearchEvent event, Emitter<MemberState> emit) async {
    final query = event.query.toLowerCase();
    final filteredMembers = _originalData.where((member) {
      final name = member.memberName?.toLowerCase() ?? '';
      final noVehicle = member.memberNoVehicle?.toLowerCase() ?? '';
      final partnerName =
          member.memberJoinPartner?.partnerName?.toLowerCase() ?? '';
      return name.contains(query) ||
          noVehicle.contains(query) ||
          partnerName.contains(query);
    }).toList();
    emit(MemberLoadDataSuccess(data: filteredMembers));
  }

  // void _onMemberSearchEvent(
  //     MemberSearchEvent event, Emitter<MemberState> emit) async {
  //   final filteredMembers = _originalData.where((member) {
  //     final name =
  //         member.memberName?.toLowerCase() ?? ''; // Handle nullable MemberName
  //     return name.contains(event.query.toLowerCase());
  //   }).toList();
  //   emit(MemberLoadDataSuccess(data: filteredMembers));
  // }

  void _onMemberExportToExcel(
      MemberExportToExcel event, Emitter<MemberState> emit) async {
    emit(const MemberLoadInProgress());

    final result = await useCase.exportToExcel(event.param);
    result.fold(
      (failure) {
        emit(MemberLoadFailure(message: failure.message));
      },
      (data) {
        emit(MemberLoadSuccess(message: data));
        emit(MemberLoadDataSuccess(data: event.param));
      },
    );
  }

  void _onMemberExportToCSV(
      MemberExportToCSV event, Emitter<MemberState> emit) async {
    emit(const MemberLoadInProgress());

    final result = await useCase.exportToCSV(event.param);
    result.fold(
      (failure) {
        emit(MemberLoadFailure(message: failure.message));
      },
      (data) {
        emit(MemberLoadSuccess(message: data));
        emit(MemberLoadDataSuccess(data: event.param));
      },
    );
  }

  void _onMemberExtend(MemberExtend event, Emitter<MemberState> emit) async {
    emit(const MemberLoadInProgress());

    // fittur extend ini menggunakan validasi register
    final errors = event.params.validateFields('extend');
    if (errors.isNotEmpty) {
      emit(MemberLoadFailure(
          message:
              'Data is not valid: ${errors.entries.map((e) => '${e.key}: ${e.value}').join(', ')}'));
      return;
    }

    final clearFormValidatorBloc = event.context.read<MemberValidatorBloc>();
    final result = await useCase.insertData(event.params);

    result.fold(
      (failure) {
        emit(MemberLoadFailure(message: failure.message));
      },
      (data) {
        clearFormValidatorBloc
            .add(MemberClearValidator(context: event.context));
        Navigator.pop(event.context);
        emit(MemberLoadSuccess(message: data));
      },
    );
  }

  @override
  Future<void> close() {
    _memberSubscription.cancel();
    return super.close();
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
