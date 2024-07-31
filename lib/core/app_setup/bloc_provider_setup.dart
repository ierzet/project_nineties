import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/core/cubit/date_picker_cubit.dart';
import 'package:project_nineties/core/cubit/global_cubit.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_dob_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_expired_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_join_date_cubit.dart';
import 'package:project_nineties/features/customer/presentation/cubit/customer_step_cubit.dart';
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
          BlocProvider(create: (context) => di.locator<CustomerBloc>()),
          BlocProvider(create: (context) => di.locator<TransactionBloc>()),
          BlocProvider(create: (context) => di.locator<MessageBloc>()),

          //cubit
          BlocProvider(create: (context) => PartnerValidatorBloc()),
          BlocProvider(create: (context) => PartnerJoinDateCubit()),
          BlocProvider(create: (context) => DatePickerCubit()),

          BlocProvider(create: (context) => CustomerValidatorBloc()),
          BlocProvider(create: (context) => CustomerJoinDateCubit()),
          BlocProvider(create: (context) => CustomerDOBDateCubit()),
          BlocProvider(create: (context) => CustomerExpiredDateCubit()),
          BlocProvider(create: (context) => ThemeCubit()),

          //BlocProvider(create: (context) => CustomerJoinDateCubit()),
          BlocProvider(create: (context) => CustomerStepCubit()),

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
