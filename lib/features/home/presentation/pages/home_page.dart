import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_customer_growth_box_chart.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_total_items_grid.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_transaction_trend_chart.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_user_activities_piechart.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.defaultPadding.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: AppStyles.chartTitle, // Using AppStyles
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            const HomeTotalItemsGrid(),
            SizedBox(height: AppPadding.defaultPadding.h),
            Text(
              'Transaction Trends',
              style: AppStyles.chartTitle,
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            SizedBox(
              height: 200.h,
              child: const HomeTransactionTrendChart(),
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            Text(
              'Transaction Trends 2',
              style: AppStyles.chartTitle,
            ),
            SizedBox(height: AppPadding.halfPadding.h),
            SizedBox(
              height: 200.h,
              child: const TransactionTrendChart2(),
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            Text(
              'Customer Growth',
              style: AppStyles.chartTitle, // Using AppStyles
            ),
            SizedBox(height: AppPadding.halfPadding.h),
            SizedBox(
              height: 200.h,
              child: const HomeCustomerGrowthBoxChart(),
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            Text(
              'User Activities',
              style: AppStyles.chartTitle, // Using AppStyles
            ),
            SizedBox(height: AppPadding.halfPadding.h),
            SizedBox(
              height: 200.h,
              child: const HomeUserActivitisPieChart(),
            ),
          ],
        ),
      ),
    );
  }
}
