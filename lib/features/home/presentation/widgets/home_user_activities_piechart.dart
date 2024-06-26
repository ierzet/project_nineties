import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class HomeUserActivitisPieChart extends StatelessWidget {
  const HomeUserActivitisPieChart({
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
          child: PieChart(
            pieChartData(),
          ),
        ),
      ),
    );
  }

  PieChartData pieChartData() {
    return PieChartData(
      sections: [
        PieChartSectionData(
          value: 40,
          title: 'Activity 1',
          color: AppColors.primary, // Using AppColors
        ),
        PieChartSectionData(
          value: 30,
          title: 'Activity 2',
          color: AppColors.secondary, // Using AppColors
        ),
        PieChartSectionData(
          value: 15,
          title: 'Activity 3',
          color: AppColors.accent, // Using AppColors
        ),
        PieChartSectionData(
          value: 15,
          title: 'Activity 4',
          color: AppColors.textColor, // Using AppColors
        ),
      ],
    );
  }
}
