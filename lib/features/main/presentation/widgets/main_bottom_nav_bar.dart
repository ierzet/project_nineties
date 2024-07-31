import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit_state.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';
import 'package:badges/badges.dart' as badges; // Import the badges package

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userAccount = context.read<AppBloc>().state.user.user;

    final senderId = userAccount.id;

    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, selectedIndex) {
        return BottomNavigationBar(
          currentIndex: selectedIndex.indexBotNavBar,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: StreamBuilder<int>(
                stream: getUnreadMessagesCount(senderId),
                builder: (context, snapshot) {
                  final count = snapshot.data ?? 0;

                  return count == 0
                      ? const Icon(Icons.message)
                      : badges.Badge(
                          position: badges.BadgePosition.topEnd(
                              top: -16.r, end: -16.r),
                          badgeContent: Text(
                            count.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            padding: EdgeInsets.all(5),
                            badgeColor: Colors.red,
                          ),
                          child: const Icon(Icons.message),
                        );
                },
              ),
              label: 'Messages',
            ),
          ],
          onTap: (index) {
            context.read<NavigationCubit>().updateIndex(index);
          },
        );
      },
    );
  }

  Stream<int> getUnreadMessagesCount(String userId) {
    final messagesCollection =
        FirebaseFirestore.instance.collection('messages');
    return messagesCollection.snapshots().map((snapshot) {
      int unreadCount = 0;
      for (var doc in snapshot.docs) {
        final message = Message.fromFirestore(doc);
        if (message.readBy[userId] != true) {
          unreadCount++;
        }
      }
      return unreadCount;
    });
  }
}
