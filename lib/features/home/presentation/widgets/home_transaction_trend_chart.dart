import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class HomeTransactionTrendChart extends StatelessWidget {
  const HomeTransactionTrendChart({super.key});

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
          child: LineChart(lineChartData()),
        ),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 1:
                  return const Text('1m', style: TextStyle(fontSize: 14));
                case 2:
                  return const Text('2m', style: TextStyle(fontSize: 14));
                case 3:
                  return const Text('3m', style: TextStyle(fontSize: 14));
                case 4:
                  return const Text('4m', style: TextStyle(fontSize: 14));
                case 5:
                  return const Text('5m', style: TextStyle(fontSize: 14));
                default:
                  return Container();
              }
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 2:
                  return const Text('SEPT', style: TextStyle(fontSize: 14));
                case 7:
                  return const Text('OCT', style: TextStyle(fontSize: 14));
                case 12:
                  return const Text('DEC', style: TextStyle(fontSize: 14));
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: AppColors.success,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(1, 1),
            FlSpot(3, 1.5),
            FlSpot(5, 1.4),
            FlSpot(7, 3.4),
            FlSpot(10, 2),
            FlSpot(12, 2.2),
            FlSpot(13, 1.8),
          ],
        ),
      ],
    );
  }
}

class TransactionTrendChart2 extends StatelessWidget {
  const TransactionTrendChart2({super.key});
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
          child: LineChart(lineChartData()),
        ),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 3),
            const FlSpot(1, 1),
            const FlSpot(2, 4),
            const FlSpot(3, 3),
            const FlSpot(4, 2),
            const FlSpot(5, 5),
            const FlSpot(6, 3),
          ],
          isCurved: true,
          color: AppColors.primary, // Using AppColors
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.primary.withOpacity(0.3), // Using AppColors
          ),
        ),
      ],
    );
  }
}
