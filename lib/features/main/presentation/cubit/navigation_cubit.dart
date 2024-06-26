import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/home/presentation/pages/home_page.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/main/presentation/widgets/widgets.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitState.initial);

  void updateIndex(int index) {
    emit(state.copyWith(indexBotNavBar: index, subMenuProfileOpt: ''));
  }

  void updateSubMenu(String subMenu) {
    emit(NavigationCubitState(
      indexBotNavBar: 0,
      subMenuProfileOpt: subMenu,
    ));
  }

  List<Widget> get widgetOptions => [
        const HomeDashboard(),
        const TransactionsWidget(),
        const MessagesWidget(),

        // const CustomersWidget(),
      ];
}
