import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/home/domain/entities/home_entity.dart';
import 'package:project_nineties/features/home/presentation/cubit/home_cubit.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_summary_card.dart';

class HomeTotalItemsGrid extends StatelessWidget {
  const HomeTotalItemsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeEntity>(
      builder: (context, state) {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: AppPadding.defaultPadding.r,
          mainAxisSpacing: AppPadding.defaultPadding.r,
          children: [
            SummaryCard(
              title: 'Total Users',
              value: state.isEmpty
                  ? '0'
                  : state.totalUsers.toString(), // Show loading indicator
              icon: Icons.person,
              color: AppColors.primary,
            ),
            SummaryCard(
              title: 'Total Transactions',
              value: state.isEmpty
                  ? '0'
                  : state.totalTransactions
                      .toString(), // Show loading indicator
              icon: Icons.swap_horiz,
              color: AppColors.success,
            ),
            SummaryCard(
              title: 'Total Members',
              value: state.isEmpty
                  ? '0'
                  : state.totalMembers.toString(), // Show loading indicator
              icon: Icons.people,
              color: AppColors.accent,
            ),
            SummaryCard(
              title: 'Total Partners',
              value: state.isEmpty
                  ? '0'
                  : state.totalPartners.toString(), // Show loading indicator
              icon: Icons.business,
              color: AppColors.warning,
            ),
          ],
        );
      },
    );
  }
}
