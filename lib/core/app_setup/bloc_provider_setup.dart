import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/core/cubit/global_cubit.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/cubit/auth_validator_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/injection_container.dart' as di;

class BlocProviderSetup extends StatelessWidget {
  final Widget child;
  final AuthenticationInitiation _authenticationInitiation;

  const BlocProviderSetup({
    super.key,
    required AuthenticationInitiation authenticationInitiation,
    required this.child,
  }) : _authenticationInitiation = authenticationInitiation;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationInitiation),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationInitiation: _authenticationInitiation,
              authenticationUseCase: di.locator<AuthenticationUseCase>(),
            ),
          ),
          BlocProvider(create: (context) => di.locator<AuthenticationBloc>()),
          BlocProvider(create: (context) => AuthValidatorCubit()),
          BlocProvider(
              create: (context) =>
                  GlobalCubit()), //TODO:kalo ga dipake hapus aja
          BlocProvider(create: (context) => NavigationCubit()),
        ],
        child: child,
      ),
    );
  }
}
