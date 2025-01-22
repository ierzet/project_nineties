import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/core/cubit/date_picker_cubit.dart';
import 'package:project_nineties/core/cubit/global_cubit.dart';
import 'package:project_nineties/features/home/presentation/cubit/home_cubit.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_bloc/member_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_dob_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_expired_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_join_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_migrate_params_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_registration_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_step_cubit.dart';
import 'package:project_nineties/features/message/presentation/bloc/message_bloc.dart';
import 'package:project_nineties/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_validator_bloc/user_validator_bloc.dart';
import 'package:project_nineties/features/user/presentation/cubit/user_validator_cubit.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_validator_bloc/authentication_validator_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/cubit/partner_join_date_cubit.dart';
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
          //bloc
          BlocProvider(create: (context) => di.locator<AuthenticationBloc>()),
          BlocProvider(create: (context) => AuthenticationValidatorBloc()),
          BlocProvider(create: (context) => di.locator<PartnerBloc>()),
          BlocProvider(create: (context) => di.locator<UserBloc>()),
          BlocProvider(create: (context) => di.locator<MemberBloc>()),
          BlocProvider(create: (context) => di.locator<TransactionBloc>()),
          BlocProvider(create: (context) => di.locator<MessageBloc>()),

          //cubit
          BlocProvider(create: (context) => PartnerValidatorBloc()),
          BlocProvider(create: (context) => PartnerJoinDateCubit()),
          BlocProvider(create: (context) => DatePickerCubit()),

          BlocProvider(create: (context) => MemberValidatorBloc()),
          BlocProvider(create: (context) => MemberJoinDateCubit()),
          BlocProvider(create: (context) => MemberDOBDateCubit()),
          BlocProvider(create: (context) => MemberRegistrationDateCubit()),
          BlocProvider(create: (context) => MemberExpiredDateCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => di.locator<HomeCubit>()),

          //BlocProvider(create: (context) => MemberJoinDateCubit()),
          BlocProvider(create: (context) => MemberStepCubit()),
          BlocProvider(create: (context) => MemberMigrateParamsCubit()),
          // BlocProvider(create: (context) => TransactionCameraFlagCubit()),

          BlocProvider(create: (context) => NavigationCubit()),
          BlocProvider(create: (context) => UserValidatorCubit()),
          BlocProvider(create: (context) => UserValidatorBloc()),
          BlocProvider(
              create: (context) =>
                  GlobalCubit()), //TODO:kalo ga dipake hapus aja
        ],
        child: child,
      ),
    );
  }
}
