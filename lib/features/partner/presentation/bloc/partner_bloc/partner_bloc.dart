import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  PartnerBloc(this.usecase) : super(const PartnerInitial()) {
    on<PartnerRegister>(_onPartnerRegister,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerGetData>(_onPartnerGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerUpdateData>(_onPartnerUpdateData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerSubscriptionSuccsess>(_onPartnerSubscriptionSuccsess,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerSubscriptionFailure>(_onPartnerSubscriptionFailure,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerExportToExcel>(_onPartnerExportToExcel,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerExportToCSV>(_onPartnerExportToCSV,
        transformer: debounce(const Duration(milliseconds: 500)));

    _partnerSubscription = usecase().listen((result) {
      result.fold(
        (failure) => add(PartnerSubscriptionFailure(message: failure.message)),
        (data) => add(PartnerSubscriptionSuccsess(params: data)),
      );
    });
  }
  final PartnerUseCase usecase;
  late final StreamSubscription _partnerSubscription;

  void _onPartnerSubscriptionSuccsess(
      PartnerSubscriptionSuccsess event, Emitter<PartnerState> emit) async {
    emit(PartnerLoadDataSuccess(data: event.params));
  }

  void _onPartnerSubscriptionFailure(
      PartnerSubscriptionFailure event, Emitter<PartnerState> emit) async {
    emit(PartnerLoadFailure(message: event.message));
  }

  void _onPartnerRegister(
      PartnerRegister event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    if (!event.params.isValid) {
      emit(const PartnerLoadFailure(message: AppStrings.dataIsNotValid));
      return;
    }
    final navigatorBloc = event.context.read<NavigationCubit>();
    final result = await usecase.insertData(event.params);
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        navigatorBloc.updateIndex(0);
        emit(PartnerLoadSuccess(message: data));
      },
    );
  }

  void _onPartnerGetData(
      PartnerGetData event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    final result = await usecase.fetchData();
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(message: failure.message));
      },
      (data) {
        emit(PartnerLoadDataSuccess(data: data));
      },
    );
  }

  void _onPartnerUpdateData(
      PartnerUpdateData event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    if (!event.params.isValid) {
      emit(const PartnerLoadFailure(message: AppStrings.dataIsNotValid));
      return;
    }
    final navigatorBloc = event.context.read<NavigationCubit>();
    final result = await usecase.updateData(event.params);
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        navigatorBloc.updateSubMenu('transaction_view');
        emit(PartnerLoadUpdateSuccess(message: data));
      },
    );
  }

  void _onPartnerExportToExcel(
      PartnerExportToExcel event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    final result = await usecase.exportToExcel(event.param);
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(message: failure.message));
      },
      (data) {
        emit(PartnerLoadSuccess(message: data));
        emit(PartnerLoadDataSuccess(data: event.param));
      },
    );
  }

  void _onPartnerExportToCSV(
      PartnerExportToCSV event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    final result = await usecase.exportToCSV(event.param);
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(message: failure.message));
      },
      (data) {
        emit(PartnerLoadSuccess(message: data));
        emit(PartnerLoadDataSuccess(data: event.param));
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  @override
  Future<void> close() {
    _partnerSubscription.cancel();
    return super.close();
  }
}
