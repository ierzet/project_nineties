import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/feature_test/partner_screen.dart';
import 'package:project_nineties/core/utilities/route_page.dart';
import 'package:project_nineties/features/account_profile/presentation/pages/profile_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_extend_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_migrate_data_member_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_register_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_update_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_view_extend_page.dart';
import 'package:project_nineties/features/member/presentation/pages/member_view_page.dart';
import 'package:project_nineties/features/message/presentation/pages/message_page.dart';

import 'package:project_nineties/features/partner/presentation/pages/partner_update_page.dart';
import 'package:project_nineties/features/partner/presentation/pages/partners_view_page.dart';
import 'package:project_nineties/features/settings/presentation/pages/settings_page.dart';
import 'package:project_nineties/features/transaction/presentation/pages/transaction_page.dart';

import 'package:project_nineties/features/transaction/presentation/pages/transaction_view_page.dart';
import 'package:project_nineties/features/transaction/presentation/widgets/transaction_review.dart';
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

    if (subMenu == 'partner_screen') {
      Navigator.of(context).push(createPageRoute(const PartnerScreen()));
    }

    //member
    if (subMenu == 'member_register') {
      Navigator.of(context)
          .push(createPageRoute(const MemberRegistrationPage()));
    }
    if (subMenu == 'member_view') {
      Navigator.of(context).push(createPageRoute(const MembersViewPage()));
    }
    if (subMenu == 'member_view_extend') {
      Navigator.of(context)
          .push(createPageRoute(const MembersViewExtendPage()));
    }

    if (subMenu == 'member_update') {
      Navigator.of(context).push(createPageRoute(const MemberUpdatePage()));
    }

    if (subMenu == 'member_extend') {
      Navigator.of(context).push(createPageRoute(const MemberExtendPage()));
    }

    if (subMenu == 'migrate_data_members') {
      Navigator.of(context)
          .push(createPageRoute(const MemberMigrateDataMemberPage()));
    }

    //popup menu
    if (subMenu == 'profile') {
      Navigator.of(context).push(createPageRoute(const ProfilePage()));
    }
    if (subMenu == 'settings') {
      Navigator.of(context).push(createPageRoute(const SettingsPage()));
    }

    //transaction
    if (subMenu == 'transaction_view') {
      Navigator.of(context).push(createPageRoute(const TransactionViewPage()));
    }
    if (subMenu == 'scan_qr') {
      Navigator.of(context).push(createPageRoute(const TransactionReview()));
    }
  }

  List<Widget> get widgetOptions => [
        const HomeDashboard(),
        const MemberQRView(),
        MessagesPage(),
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
      // case 'member_register':
      //   return const MemberRegistrationPage();
      // case 'member_view':
      //   return const MembersViewPage();
      // case 'member_update':
      //   return const MemberUpdatePage();
      // case 'transaction_view':
      //   return const TransactionViewPage();
      case 'message':
        return MessagesPage();
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
      case 'member_register':
        return 'Member Registration';
      case 'member_view':
        return 'Members View';
      case 'member_view_extend':
        return 'Members View Extend';
      case 'member_update':
        return 'Member Update';
      case 'member_extend':
        return 'Member Extend';
      case 'transaction_view':
        return 'Transaction View';
      case 'user_approval':
        return 'User Approval';
      case 'settings':
        return 'Settings';
      case 'partner_screen':
        return 'Partner Screen';
      case 'migrate_data_members':
        return 'Migrate Data Members';
      case 'scan_qr':
        return 'Scan QRCode';

      default:
        switch (state.indexBotNavBar) {
          case 0:
            return '90s  Car Wash';
          case 1:
            return 'Member QR';
          case 2:
            return 'Messages';
          default:
            return '90s  Car Wash';
        }
    }
  }
}
