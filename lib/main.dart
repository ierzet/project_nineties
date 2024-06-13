import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/core/utilities/route.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  di.setupLocator();

  final authenticationInitiation = AuthenticationInitiation();
  await authenticationInitiation.user.first;
  runApp(ProjectNineties(authenticationInitiation: authenticationInitiation));
}

class ProjectNineties extends StatelessWidget {
  const ProjectNineties({
    super.key,
    required AuthenticationInitiation authenticationInitiation,
  }) : _authenticationInitiation = authenticationInitiation;

  final AuthenticationInitiation _authenticationInitiation;
  @override
  Widget build(BuildContext context) {
    return BlocProviderSetup(
      authenticationInitiation: _authenticationInitiation,
      child: const AppSetup(),
    );
  }
}

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
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}

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
            : imageColorScheme!.primary,
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
