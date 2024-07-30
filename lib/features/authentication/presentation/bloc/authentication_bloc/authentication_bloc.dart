import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_params.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:project_nineties/features/authentication/domain/usecases/confirmed_password.dart';
import 'package:project_nineties/features/authentication/domain/usecases/email.dart';
import 'package:project_nineties/features/authentication/domain/usecases/password.dart';
import 'package:project_nineties/features/authentication/domain/usecases/register_authentication.dart';
import 'package:project_nineties/features/authentication/domain/usecases/user_dynamic.dart';
import 'package:rxdart/rxdart.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.authenticationUseCase)
      : super(const AuthenticationInitial()) {
    on<AuthEmailAndPasswordLogIn>(_onAuthEmailAndPasswordLogIn,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<AuthGoogleLogIn>(_onAuthGoogleLogIn,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<AuthFacebookLogin>(_onAuthFacebookLogin,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<AuthUserSignUp>(_onAuthUserSignUp,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<AuthUserLogOut>(_onAuthUserLogOut,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<AuthResetPassword>(_onAuthResetPassword,
        transformer: debounce(const Duration(milliseconds: 500)));

    on<AuthRegisterValidationChange>(_onEmailAndPasswordRegisterChanged);
  }

  final AuthenticationUseCase authenticationUseCase;

  void _onAuthEmailAndPasswordLogIn(AuthEmailAndPasswordLogIn event,
      Emitter<AuthenticationState> emit) async {
    const AuthenticationLoading();
    final isValid = event.params.isValidSignin;

    emit(
      isValid
          ? const AuthenticationLoading()
          : AuthValidationButton(
              emailIsValid: event.params.isEmailValid,
              passwordIsValid: event.params.isPasswordValid,
            ),
    );
    if (!isValid) {
      return;
    }
    final result =
        await authenticationUseCase.authenticateEmailAndPassword(event.params);

    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.message));
      },
      (data) {
        emit(data.isNotEmpty
            ? AuthenticationLoaded.authenticated(data)
            : const AuthenticationLoaded.unauthenticated());
      },
    );
  }

  void _onAuthGoogleLogIn(
      AuthGoogleLogIn event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationLoading());

    final result = await authenticationUseCase.authenticateGoogleSignIn();
    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.message));
      },
      (data) {
        emit(data.isNotEmpty
            ? AuthenticationLoaded.authenticated(data)
            : const AuthenticationLoaded.unauthenticated());
      },
    );
  }

  void _onAuthFacebookLogin(
      AuthFacebookLogin event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationLoading());

    final result = await authenticationUseCase.authenticateFacebookSignIn();
    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.message));
      },
      (data) {
        emit(data.isNotEmpty
            ? AuthenticationLoaded.authenticated(data)
            : const AuthenticationLoaded.unauthenticated());
      },
    );
  }

  void _onAuthUserSignUp(
      AuthUserSignUp event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationRegistering());

    final isValid = event.params.isValidSignUp;

    emit(
      isValid
          ? const AuthenticationRegistering()
          : AuthValidationRegister.isNotValid,
    );

    if (!isValid) {
      return;
    }

    final result = await authenticationUseCase.register(event.params);

    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.message));
      },
      (data) {
        emit(AuthenticationRegistered(data));
        
      },
    );
  }

  void _onAuthUserLogOut(
      AuthUserLogOut event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationLogingOff());
    final result = await authenticationUseCase.onLogOut();
    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.message));
      },
      (data) {
        emit(const AuthenticationLoaded.unauthenticated());
      },
    );
  }

  void _onAuthResetPassword(
      AuthResetPassword event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationLoading());

    final emailObj = Email.dirty(event.email);
    if (!emailObj.isValid) {
      emit(AuthValidationResetPassword(emailIsValid: emailObj.isValid));
      return;
    }

    final result = await authenticationUseCase.resetPassword(event.email);
    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.message));
      },
      (data) {
        emit(AuthResetPasswordSuccess(message: data));
      },
    );
  }

  void _onEmailAndPasswordRegisterChanged(
      AuthRegisterValidationChange event, Emitter<AuthenticationState> emit) {
    final email = Email.dirty(event.credential.email);
    final password = Password.dirty(event.credential.password);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: event.credential.password,
      value: event.credential.confirmedPassword,
    );
    emit(
      AuthValidationRegister(
          emailIsValid: email.isValid,
          passwordIsValid: password.isValid,
          confirmedPasswordIsValid: confirmedPassword.isValid,
          email: event.credential.email,
          password: event.credential.password),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
