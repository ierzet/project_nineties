import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_summary_card.dart';

class HomeTotalItemsGrid extends StatelessWidget {
  const HomeTotalItemsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: AppPadding.defaultPadding.r,
      mainAxisSpacing: AppPadding.defaultPadding.r,
      children: const [
        SummaryCard(
          title: 'Total Users',
          value: '1500',
          icon: Icons.person,
          color: AppColors.primary, // Using AppColors
        ),
        SummaryCard(
          title: 'Total Transactions',
          value: '3200',
          icon: Icons.swap_horiz,
          color: AppColors.success, // Using new AppColors
        ),
        SummaryCard(
          title: 'Total Customers',
          value: '2800',
          icon: Icons.people,
          color: AppColors.accent, // Using AppColors
        ),
        SummaryCard(
          title: 'Total Partners',
          value: '35',
          icon: Icons.business,
          color: AppColors.warning, // Using a more distinct color
        ),
      ],
    );
  }
}
