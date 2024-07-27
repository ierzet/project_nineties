import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationInitiation authenticationInitiation,
    required this.authenticationUseCase,
  })  : _authenticationInitiation = authenticationInitiation,
        super(
          authenticationInitiation.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationInitiation.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged,
        transformer: debounce(const Duration(milliseconds: 500)));
    // on<NavigateToSignup>(_onNavigateToSignup);
    // on<NavigateToForgotPassword>(_onNavigateToForgotPassword);

    _userSubscription = _authenticationInitiation.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthenticationUseCase authenticationUseCase;
  final AuthenticationInitiation _authenticationInitiation;
  late final StreamSubscription<UserAccountEntity> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    emit(const AppState.loading()); // Emit loading state
    if (event.user.isNotEmpty) {
      final result =
          await authenticationUseCase.getUserAccountById(event.user.user.id);
      result.fold(
        (failure) {
          emit(const AppState.unauthenticated());
        },
        (data) {
          final updatedUser = event.user.copyWith(isInitiate: data.isInitiate);
          if (data.isEmpty || updatedUser.isInitiate == true) {
            emit(const AppState.unauthenticated());
          } else {
            //emit(AppState.authenticated(updatedUser));
            emit(AppState.authenticated(data));
          }
        },
      );
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  // void _onNavigateToSignup(NavigateToSignup event, Emitter<AppState> emit) {
  //   emit(const AppState.signup());
  // }

  // void _onNavigateToForgotPassword(
  //     NavigateToForgotPassword event, Emitter<AppState> emit) {
  //   emit(const AppState.forgotPassword());
  // }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
