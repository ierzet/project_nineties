import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/route.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/settings/domain/entities/setting_entity.dart';
import 'package:project_nineties/features/settings/presentation/cubit/theme_cubit.dart';

class AppSetup extends StatelessWidget {
  const AppSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(414, 896),
      child: ThemeHandler(
        child: AuthFlow(),
      ),
    );
  }
}

class ThemeHandler extends StatelessWidget {
  const ThemeHandler({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, SettingsEntity>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '90s Connect',
          themeMode: state.themeMode,
          theme: ThemeData(
            colorSchemeSeed: state.colorSeed.color,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: state.colorSeed.color,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          home: child,
        );
      },
    );
  }
}

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.status == AppStatus.loading) {
          return const LoadingPage();
        }
        return FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        );
      },
    );
  }
}


// class AppSetup extends StatelessWidget {
//   const AppSetup({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, SettingsEntity>(
//       builder: (context, state) {
//         return ScreenUtilInit(
//           minTextAdapt: true,
//           splitScreenMode: true,
//           designSize: const Size(414, 896),
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: '90s Connect',
//             themeMode: state.themeMode,
//             theme: ThemeData(
//               colorSchemeSeed: state.colorSeed.color, // Access color property
//               useMaterial3: true,
//               brightness: Brightness.light,
//             ),
//             darkTheme: ThemeData(
//               colorSchemeSeed: state.colorSeed.color, // Access color property
//               useMaterial3: true,
//               brightness: Brightness.dark,
//             ),
//             home: BlocBuilder<AppBloc, AppState>(
//               builder: (context, state) {
//                 if (state.status == AppStatus.loading) {
//                   return const LoadingPage(); // Show loading page during auth check
//                 }
//                 return FlowBuilder<AppStatus>(
//                   state: context.select((AppBloc bloc) => bloc.state.status),
//                   onGeneratePages: onGenerateAppViewPages,
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

