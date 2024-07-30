import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/user/domain/usecases/user_params.dart';
import 'package:project_nineties/features/user/domain/usecases/user_usecase.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:rxdart/rxdart.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.usecase}) : super(UserInitial()) {
    on<UserGetData>(_onUserGetData,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserApproval>(_onUserApproval,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserRegisterByAdmin>(_onUserRegisterByAdmin,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserSubscriptionSuccess>(_onUserSubscriptionSuccess,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserSubscriptionFailure>(_onUserSubscriptionFailure,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserExportToExcel>(_onUserExportToExcel,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<UserExportToCSV>(_onUserExportToCSV,
        transformer: debounce(const Duration(milliseconds: 500)));

    _userSubscription = usecase().listen((result) {
      result.fold(
        (failure) => add(UserSubscriptionFailure(message: failure.message)),
        (data) => add(UserSubscriptionSuccess(params: data)),
      );
    });
  }
  late StreamSubscription _userSubscription;
  final UserUseCase usecase;

  void _onUserSubscriptionSuccess(
      UserSubscriptionSuccess event, Emitter<UserState> emit) async {
    emit(UserLoadDataSuccess(data: event.params));
  }

  void _onUserSubscriptionFailure(
      UserSubscriptionFailure event, Emitter<UserState> emit) async {
    emit(UserLoadFailure(message: event.message));
  }

  void _onUserGetData(UserGetData event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    final result = await usecase.fetchUsers();
    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        emit(UserLoadDataSuccess(data: data));
      },
    );
  }

  void _onUserApproval(UserApproval event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    if (event.userAccountEntity.partner.partnerId == '' ||
        event.userAccountEntity.roleId == null ||
        event.userAccountEntity.roleId == '') {
      emit(const UserLoadFailure(message: 'partner or role should be filled'));
      return;
    }

    final navigatorBloc = event.context.read<NavigationCubit>();
    final result = await usecase.approvalUser(event.userAccountEntity.copyWith(
      updatedBy: event.updatedUser,
      updatedDate: DateTime.now(),
    ));

    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        //back to home
        navigatorBloc.updateIndex(0);
        emit(UserLoadApprovalSuccess(message: data));
      },
    );
  }

  void _onUserRegisterByAdmin(
      UserRegisterByAdmin event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    if (event.params.partner.partnerId == '' || event.params.roleId == '') {
      emit(const UserLoadFailure(message: 'partner or role should be filled'));
      return;
    }

    final isValid = event.params.isValidSignUp;

    emit(
      isValid
          ? const UserLoadInProgress()
          : const UserLoadFailure(message: 'data tidak valiid'),
    );

    if (!isValid) {
      return;
    }

    final result = await usecase.registerUser(event.params);

    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        emit(const UserLoadRegisterSuccess(message: ''));
      },
    );
  }

  void _onUserExportToExcel(
      UserExportToExcel event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    final result = await usecase.exportToExcel(event.param);
    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        emit(UserLoadSuccess(message: data));
        emit(UserLoadDataSuccess(data: event.param));
      },
    );
  }

  void _onUserExportToCSV(
      UserExportToCSV event, Emitter<UserState> emit) async {
    emit(const UserLoadInProgress());

    final result = await usecase.exportToCSV(event.param);
    result.fold(
      (failure) {
        emit(UserLoadFailure(message: failure.message));
      },
      (data) {
        emit(UserLoadSuccess(message: data));
        emit(UserLoadDataSuccess(data: event.param));
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
