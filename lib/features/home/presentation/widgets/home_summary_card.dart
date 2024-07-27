import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
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
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                        value: 0, child: Text('View Details')),
                    const PopupMenuItem<int>(value: 1, child: Text('Edit')),
                    const PopupMenuItem<int>(value: 2, child: Text('Delete')),
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

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Handle view details action
        break;
      case 1:
        // Handle edit action
        break;
      case 2:
        // Handle delete action
        break;
    }
  }
}
