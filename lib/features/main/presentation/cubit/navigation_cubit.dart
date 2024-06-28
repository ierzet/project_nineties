import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/home/presentation/pages/home_page.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/main/presentation/widgets/widgets.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_page.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitState.initial);

  void updateIndex(int index) {
    emit(state.copyWith(indexBotNavBar: index, subMenuProfileOpt: ''));
  }

  void updateSubMenu(String subMenu) {
    emit(state.copyWith(
      subMenuProfileOpt: subMenu,
    ));
  }

  List<Widget> get widgetOptions => [
        const HomeDashboard(),
        const TransactionsWidget(),
        const MessagesWidget(),
      ];

  // List<Widget> get widgetOptions => [
  //       const PartnerRegistrationPage(),
  //       const PartnerRegistrationPage(),
  //       const PartnerRegistrationPage(),
  //     ];

  Widget getCurrentWidget() {
    switch (state.subMenuProfileOpt) {
      case 'profile':
        return const AccountWidget();
      case 'partner':
        return const PartnerRegistrationPage();
      default:
        return widgetOptions[state.indexBotNavBar];
    }
  }
  // Widget getCurrentWidget() {
  //   switch (state.subMenuProfileOpt) {
  //     case 'profile':
  //       return const PartnerRegistrationPage();
  //     case 'partner':
  //       return const PartnerRegistrationPage();
  //     default:
  //       return widgetOptions[state.indexBotNavBar];
  //   }
  // }
}
