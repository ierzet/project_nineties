import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_bloc/member_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onExportToExcel;
  final VoidCallback? onExportToCSV;
  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onExportToExcel,
    this.onExportToCSV,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          //color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 40.r,
                  color: color,
                ),
                PopupMenuButton<int>(
                  icon: Icon(
                    Icons.more_vert,
                    color: color,
                  ),
                  onSelected: (item) => onSelected(context, item, title),
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                        value: 0, child: Text('View Details')),
                    const PopupMenuItem<int>(
                        value: 1, child: Text('Export to Excel')),
                    const PopupMenuItem<int>(
                        value: 2, child: Text('Export to CSV')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: AppStyles.bodyTextBold.copyWith(
                color: color,
              ), // Consistent style
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: AppStyles.header.copyWith(
                fontSize: 24.r,
                color: color,
              ), // Emphasized value
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item, String title) {
    if (title == 'Total Members') {
      final memberBloc = context.read<MemberBloc>();
      final memberState = memberBloc.state;
      switch (item) {
        case 0:
          context.read<NavigationCubit>().updateSubMenuWithAnimated(
              context: context, subMenu: 'member_view');
          break;
        case 1:
          if (memberState is MemberLoadDataSuccess) {
            memberBloc.add(MemberExportToExcel(param: memberState.data));
          }
          break;
        case 2:
          if (memberState is MemberLoadDataSuccess) {
            memberBloc.add(MemberExportToCSV(param: memberState.data));
          }
          break;
      }
    } else if (title == 'Total Transactions') {
      final transactionBloc = context.read<TransactionBloc>();
      final transactionState = transactionBloc.state;
      switch (item) {
        case 0:
          context.read<NavigationCubit>().updateSubMenuWithAnimated(
              context: context, subMenu: 'transaction_view');
          break;
        case 1:
          if (transactionState is TransactionLoadDataSuccess) {
            transactionBloc
                .add(TransactionExportToExcel(param: transactionState.data));
          }
          break;
        case 2:
          if (transactionState is TransactionLoadDataSuccess) {
            transactionBloc
                .add(TransactionExportToCSV(param: transactionState.data));
          }
          break;
      }
    } else if (title == 'Total Partners') {
      final partnerBloc = context.read<PartnerBloc>();
      final partnerState = partnerBloc.state;
      switch (item) {
        case 0:
          context.read<NavigationCubit>().updateSubMenuWithAnimated(
              context: context, subMenu: 'partners_view');
          break;
        case 1:
          if (partnerState is PartnerLoadDataSuccess) {
            partnerBloc.add(PartnerExportToExcel(param: partnerState.data));
          }
          break;
        case 2:
          if (partnerState is PartnerLoadDataSuccess) {
            partnerBloc.add(PartnerExportToCSV(param: partnerState.data));
          }
          break;
      }
    } else if (title == 'Total Users') {
      final userBloc = context.read<UserBloc>();
      final userState = userBloc.state;
      switch (item) {
        case 0:
          context.read<NavigationCubit>().updateSubMenuWithAnimated(
              context: context, subMenu: 'users_view');
          break;
        case 1:
          if (userState is UserLoadDataSuccess) {
            userBloc.add(UserExportToExcel(param: userState.data));
          }
          break;
        case 2:
          if (userState is UserLoadDataSuccess) {
            userBloc.add(UserExportToCSV(param: userState.data));
          }
          break;
      }
    } else {
      switch (item) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    }
  }
}
