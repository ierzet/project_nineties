import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/admin/presentation/pages/user_approval_page.dart';
import 'package:project_nineties/features/admin/presentation/pages/view_user_page.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/home/presentation/pages/home_page.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/main/presentation/widgets/widgets.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_page.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitState.initial);

  void updateIndex(int index) {
    emit(state.copyWith(
        indexBotNavBar: index, subMenuProfileOpt: '', userAccountEntity: null));
  }

  void updateSubMenu(String subMenu) {
    emit(state.copyWith(subMenuProfileOpt: subMenu, userAccountEntity: null));
  }

  void updateSubMenuWithUser(String subMenu, UserAccountEntity user) {
    emit(state.copyWith(subMenuProfileOpt: subMenu, userAccountEntity: user));
  }

  List<Widget> get widgetOptions => [
        const HomeDashboard(),
        const TransactionsWidget(),
        const MessagesWidget(),
      ];

  Widget getCurrentWidget() {
    switch (state.subMenuProfileOpt) {
      case 'profile':
        return const AccountWidget();
      case 'partner':
        return const PartnerRegistrationPage();
      case 'view_users':
        return const ViewUsersPage();
      case 'user_approval':
        return UserApprovalPage(
            user: state
                .userAccountEntity!); // Gunakan parameter UserAccountEntity
      default:
        return widgetOptions[state.indexBotNavBar];
    }
  }
}
