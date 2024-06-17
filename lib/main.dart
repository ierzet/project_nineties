import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/core/app_setup/app_setup.dart';
import 'package:project_nineties/core/app_setup/authentication_init.dart';
import 'package:project_nineties/core/app_setup/bloc_provider_setup.dart';
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
