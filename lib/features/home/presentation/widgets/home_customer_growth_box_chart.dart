import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class HomeCustomerGrowthBoxChart extends StatelessWidget {
  const HomeCustomerGrowthBoxChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SizedBox(
          height: 200.h,
          child: BarChart(barChartData()),
        ),
      ),
    );
  }

  BarChartData barChartData() {
    return BarChartData(
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              fromY: 8,
              color: AppColors.accent, // Using AppColors
              toY: 2000,
            )
          ],
        ),
      ],
    );
  }
}
