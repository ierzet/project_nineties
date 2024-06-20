import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/route.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';

class AppSetup extends StatelessWidget {
  const AppSetup({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool useMaterial3 = true;
    ThemeMode themeMode = ThemeMode.system;
    ColorSeed colorSelected = ColorSeed.baseColor;
    ColorScheme? imageColorScheme = const ColorScheme.light();
    ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;
    // context.read<AuthenticationBloc>().add(const AuthUserChanged());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '90s Connect',
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected.color
            : null,
        colorScheme: colorSelectionMethod == ColorSelectionMethod.image
            ? imageColorScheme
            : null,
        useMaterial3: useMaterial3,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected.color
            // : imageColorScheme!.primary,
            : imageColorScheme.primary,
        useMaterial3: useMaterial3,
        brightness: Brightness.dark,
      ),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
