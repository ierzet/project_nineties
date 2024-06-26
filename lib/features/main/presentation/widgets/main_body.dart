import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/main/presentation/widgets/widgets.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();
    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, state) {
        return state.subMenuProfileOpt == 'profile'
            ? const AccountWidget()
            : cubit.widgetOptions[state.indexBotNavBar];
      },
    );
  }
}
