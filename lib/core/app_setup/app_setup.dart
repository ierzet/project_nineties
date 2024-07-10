import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/route.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';

class AppSetup extends StatelessWidget {
  const AppSetup({super.key});

  @override
  Widget build(BuildContext context) {
    bool useMaterial3 = true;
    ThemeMode themeMode = ThemeMode.system;
    ColorSeed colorSelected = ColorSeed.deepOrange;

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(414, 896),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '90s Connect',
        themeMode: themeMode,
        theme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          useMaterial3: useMaterial3,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          useMaterial3: useMaterial3,
          brightness: Brightness.dark,
        ),
        home: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.status == AppStatus.loading) {
              return const LoadingPage(); // Show loading page during auth check
            }
            return FlowBuilder<AppStatus>(
              state: context.select((AppBloc bloc) => bloc.state.status),
              onGeneratePages: onGenerateAppViewPages,
            );
          },
        ),
      ),
    );
  }
}

// home: BlocBuilder<AppBloc, AppState>(
//           builder: (context, state) {
//             if (state.status == AppStatus.loading) {
//               return const LoadingPage(); // Show loading page during auth check
//             } else if (state.status == AppStatus.authenticated) {
//               return const MainDashboardPage();
//             } else if (state.status == AppStatus.unauthenticated) {
//               return const AuthenticationPage();
//             } else if (state.status == AppStatus.signup) {
//               return SignupPage();
//             } else if (state.status == AppStatus.forgotPassword) {
//               return ForgotPasswordPage();
//             } else {
//               return const ErrorPage(); // Optional error handling
//             }
//           },
//         ),

// home: BlocBuilder<AppBloc, AppState>(
//           builder: (context, state) {
//             if (state.status == AppStatus.loading) {
//               return const LoadingPage(); // Show loading page during auth check
//             }
//             return FlowBuilder<AppStatus>(
//               state: context.select((AppBloc bloc) => bloc.state.status),
//               onGeneratePages: onGenerateAppViewPages,
//             );
//           },
//         ),