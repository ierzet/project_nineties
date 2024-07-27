import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/route_page.dart';
import 'package:project_nineties/features/account_profile/presentation/pages/profile_page.dart';
import 'package:project_nineties/features/customer/presentation/pages/customer_register_page.dart';
import 'package:project_nineties/features/customer/presentation/pages/customer_update_page.dart';
import 'package:project_nineties/features/customer/presentation/pages/customer_view_page.dart';
import 'package:project_nineties/features/message/presentation/pages/message.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_update_page.dart';
import 'package:project_nineties/features/partner/presentation/pages/partners_view_page.dart';
import 'package:project_nineties/features/settings/presentation/pages/settings_page.dart';
import 'package:project_nineties/features/transaction/presentation/pages/transaction_page.dart';
import 'package:project_nineties/features/transaction/presentation/pages/transaction_view_page.dart';
import 'package:project_nineties/features/user/presentation/pages/user_approval_page.dart';
import 'package:project_nineties/features/user/presentation/pages/user_register_admin_page.dart';
import 'package:project_nineties/features/user/presentation/pages/users_view_page.dart';
import 'package:project_nineties/features/home/presentation/pages/home_page.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/partner/presentation/pages/partner_register_page.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitState.initial);

  void updateIndex(int index) {
    emit(
      state.copyWith(
        indexBotNavBar: index,
        subMenuProfileOpt: '',
      ),
    );
  }

  void updateSubMenu(String subMenu) {
    emit(state.copyWith(
      subMenuProfileOpt: subMenu,
    ));
  }

  void updateSubMenuWithAnimated(
      {required BuildContext context, required String subMenu}) {
    emit(state.copyWith(
      subMenuProfileOpt: subMenu,
    ));

    //user
    if (subMenu == 'register_user_admin') {
      Navigator.of(context)
          .push(createPageRoute(const UserRegisterAdminPage()));
    }
    if (subMenu == 'users_view') {
      Navigator.of(context).push(createPageRoute(const UsersViewPage()));
    }
    if (subMenu == 'user_approval') {
      Navigator.of(context).push(createPageRoute(const UserApprovalPage()));
    }

    //partner
    if (subMenu == 'partner') {
      Navigator.of(context)
          .push(createPageRoute(const PartnerRegistrationPage()));
    }
    if (subMenu == 'partners_view') {
      Navigator.of(context).push(createPageRoute(const PartnersViewPage()));
    }
    if (subMenu == 'partner_update') {
      Navigator.of(context).push(createPageRoute(const PartnerUpdatePage()));
    }

    //customer
    if (subMenu == 'customer_register') {
      Navigator.of(context)
          .push(createPageRoute(const CustomerRegistrationPage()));
    }
    if (subMenu == 'customer_view') {
      Navigator.of(context).push(createPageRoute(const CustomersViewPage()));
    }
    if (subMenu == 'customer_update') {
      Navigator.of(context).push(createPageRoute(const CustomerUpdatePage()));
    }

    //popup menu
    if (subMenu == 'profile') {
      Navigator.of(context).push(createPageRoute(const ProfilePage()));
    }
    if (subMenu == 'settings') {
      Navigator.of(context).push(createPageRoute(const SettingsPage()));
    }
  }

  List<Widget> get widgetOptions => [
        const HomeDashboard(),
        const CustomerQRView(),
        ChatGroupPage(),
      ];

  Widget getCurrentWidget() {
    switch (state.subMenuProfileOpt) {
      // case 'profile':
      //   return const ProfilePage();
      // case 'settings':
      //   return const SettingsPage();
      // case 'partner':
      //   return const PartnerRegistrationPage();
      // case 'partners_view':
      //   return const PartnersViewPage();
      // case 'user_approval':
      //   return const UserApprovalPage();
      // case 'partner_update':
      //   return const PartnerUpdatePage();
      // case 'register_user_admin':
      //   return const UserRegisterAdminPage();
      // case 'users_view':
      //   return const UsersViewPage();
      // case 'customer_register':
      //   return const CustomerRegistrationPage();
      // case 'customer_view':
      //   return const CustomersViewPage();
      // case 'customer_update':
      //   return const CustomerUpdatePage();
      case 'transaction_view':
        return const TransactionViewPage();
      case 'message':
        return ChatGroupPage();
      default:
        return widgetOptions[state.indexBotNavBar];
    }
  }

  String getAppBarTitle() {
    switch (state.subMenuProfileOpt) {
      case 'profile':
        return 'Profile';
      case 'partner':
        return 'Partner Registration';
      case 'partners_view':
        return 'Partners View';
      case 'partner_update':
        return 'Partner Update';
      case 'register_user_admin':
        return 'Register Admin User';
      case 'users_view':
        return 'Users View';
      case 'customer_register':
        return 'Customer Registration';
      case 'customer_view':
        return 'Customers View';
      case 'customer_update':
        return 'Customer Update';
      case 'transaction_view':
        return 'Transaction View';
      case 'user_approval':
        return 'User Approval';
      case 'settings':
        return 'Settings';

      default:
        switch (state.indexBotNavBar) {
          case 0:
            return '90s  Car Wash';
          case 1:
            return 'Customer QR';
          case 2:
            return 'Messages';
          default:
            return '90s  Car Wash';
        }
    }
  }
}
