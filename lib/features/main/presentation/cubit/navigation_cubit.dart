import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_update_page.dart';
import 'package:project_nineties/features/partner/presentation/pages/partners_view_page.dart';
import 'package:project_nineties/features/user/presentation/pages/user_approval_page.dart';
import 'package:project_nineties/features/user/presentation/pages/user_register_admin_page.dart';
import 'package:project_nineties/features/user/presentation/pages/users_view_page.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';
import 'package:project_nineties/features/home/presentation/pages/home_page.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/main/presentation/widgets/widgets.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_register_page.dart';

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
    //UserRegisterAdminPage
    switch (state.subMenuProfileOpt) {
      case 'profile':
        return const AccountWidget();
      case 'partner':
        return const PartnerRegistrationPage();
      case 'partners_view':
        return const PartnersViewPage();
      case 'partner_update':
        return const PartnerUpdatePage();
      case 'register_user_admin':
        return const UserRegisterAdminPage();
      case 'users_view':
        return const UsersViewPage();
      case 'user_approval':
        return UserApprovalPage(
            user: state
                .userAccountEntity!); // Gunakan parameter UserAccountEntity
      default:
        return widgetOptions[state.indexBotNavBar];
    }
  }
}
