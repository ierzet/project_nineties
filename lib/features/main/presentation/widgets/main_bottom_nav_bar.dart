import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, selectedIndex) {
        return BottomNavigationBar(
          currentIndex: selectedIndex.indexBotNavBar,
          //selectedItemColor: AppColors.accent,
          //unselectedItemColor: AppColors.primary,
          //backgroundColor: AppColors.background,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.people),
            //   label: 'Customers',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.account_circle),
            //   label: 'Account',
            // ),
          ],
          onTap: (index) {
            context.read<NavigationCubit>().updateIndex(index);
          },
        );
      },
    );
  }
}
