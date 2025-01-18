import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/widgets/listener_notify_member.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_member_growth_box_chart.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_line_chart_sample2.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_total_items_grid.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_line_chart_sample1.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_transaction_trend_chart.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_user_activities_piechart.dart';
import 'package:project_nineties/features/partner/presentation/widgets/listener_notify_partner.dart';
import 'package:project_nineties/features/transaction/presentation/widgets/listener_notification_transaction.dart';
import 'package:project_nineties/features/user/presentation/widgets/user_listener_notification.dart';

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
            const ChartHeader(title: AppStrings.dashboard),
            SizedBox(height: AppPadding.defaultPadding.h),
            const HomeTotalItemsGrid(),
            SizedBox(height: AppPadding.defaultPadding.h),
            const ChartHeader(title: AppStrings.transactionTrends),
            SizedBox(height: AppPadding.defaultPadding.h),
            SizedBox(
              height: AppPadding.triplePadding.h * 4,
              child: const LineChartSample1(),
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            SizedBox(
              height: AppPadding.triplePadding.h * 4,
              child: const LineChartSample2(),
            ),
            //SizedBox(height: AppPadding.defaultPadding.h),
            // SizedBox(
            //   height: AppPadding.triplePadding.h * 4,
            //   child: BarChartSample1(),
            // ),
            //BarChartSample1(),
            SizedBox(height: AppPadding.defaultPadding.h),
            const ChartHeader(title: '${AppStrings.transactionTrends} 2'),
            SizedBox(height: AppPadding.halfPadding.h),
            SizedBox(
              height: AppPadding.triplePadding.h * 4,
              child: const TransactionTrendChart2(),
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            const ChartHeader(title: AppStrings.memberGrowth),
            SizedBox(height: AppPadding.halfPadding.h),
            SizedBox(
              height: AppPadding.triplePadding.h * 4,
              child: const HomeMemberGrowthBoxChart(),
            ),
            SizedBox(height: AppPadding.defaultPadding.h),
            const ChartHeader(title: AppStrings.userActivities),
            SizedBox(height: AppPadding.halfPadding.h),
            SizedBox(
              height: AppPadding.triplePadding.h * 4,
              child: const HomeUserActivitisPieChart(),
            ),
            const ListenerNotificationMember(),
            const ListenerNotificationPartner(),
            const ListenerNotificationTransaction(),
            const UserListenerNotification(),
          ],
        ),
      ),
    );
  }
}

class ChartHeader extends StatelessWidget {
  final String title;

  const ChartHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyles.chartTitle.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
