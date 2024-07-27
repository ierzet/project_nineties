import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:project_nineties/features/home/presentation/widgets/home_summary_card.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';

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
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            String itemCount = '0';

            if (state is UserLoadSuccess) {
              itemCount = state.data.length
                  .toString(); // Assuming data is a list of users
            }
            return SummaryCard(
              title: 'Total Users',
              value: itemCount,
              icon: Icons.person,
              color: AppColors.primary, // Using AppColors
            );
          },
        ),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            String itemCount = '0';

            if (state is TransactionLoadDataSuccess) {
              itemCount = state.data.length
                  .toString(); // Assuming data is a list of users
            }
            return SummaryCard(
              title: 'Total Transactions',
              value: itemCount,
              icon: Icons.swap_horiz,
              color: AppColors.success, // Using new AppColors
            );
          },
        ),
        BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            String itemCount = '0';

            if (state is CustomerLoadDataSuccess) {
              itemCount = state.data.length
                  .toString(); // Assuming data is a list of users
            }
            return SummaryCard(
              title: 'Total Customers',
              value: itemCount,
              icon: Icons.people,
              color: AppColors.accent, // Using AppColors
            );
          },
        ),
        BlocBuilder<PartnerBloc, PartnerState>(
          builder: (context, state) {
            String itemCount = '0';

            if (state is PartnerLoadDataSuccess) {
              itemCount = state.data.length
                  .toString(); // Assuming data is a list of users
            }
            return SummaryCard(
              title: 'Total Partners',
              value: itemCount,
              icon: Icons.business,
              color: AppColors.warning, // Using a more distinct color
            );
          },
        ),
      ],
    );
  }
}
