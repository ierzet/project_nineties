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
    on<AdminRegPartnerClicked>(_onAdminRegPartnerClicked,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<PartnerGetData>(_onPartnerGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
  }
  final PartnerUseCase usecase;

  void _onAdminRegPartnerClicked(
      AdminRegPartnerClicked event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    if (!event.params.isValid) {
      emit(const PartnerLoadFailure(AppStrings.dataIsNotValid));
      return;
    }
    final navigatorBloc = event.context.read<NavigationCubit>();
    final result = await usecase.insertData(event.params);
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(failure.message));
      },
      (data) {
        //back to home
        navigatorBloc.updateIndex(0);
        emit(PartnerLoadSuccess(data));
      },
    );
  }

  void _onPartnerGetData(
      PartnerGetData event, Emitter<PartnerState> emit) async {
    emit(const PartnerLoadInProgress());

    final result = await usecase.fetchPartners();
    result.fold(
      (failure) {
        emit(PartnerLoadFailure(failure.message));
      },
      (data) {
        emit(PartnerLoadDataSuccess(data: data));
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
