import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationInitiation authenticationInitiation})
      : _authenticationInitiation = authenticationInitiation,
        super(
          authenticationInitiation.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationInitiation.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<NavigateToSignup>(_onNavigateToSignup); // Add this line

    _userSubscription = _authenticationInitiation.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthenticationInitiation _authenticationInitiation;
  late final StreamSubscription<UserAccountEntity> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onNavigateToSignup(NavigateToSignup event, Emitter<AppState> emit) {
    // Add this function

    emit(const AppState.signup());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
