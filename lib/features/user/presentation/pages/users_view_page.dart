import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/user/presentation/cubit/user_validator_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';

class UsersViewPage extends StatelessWidget {
  const UsersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(const UserGetData());
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.defaultPadding),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoadSuccess) {
              final users = state.data;
              users.sort((a, b) => (a.isActive ?? false) ? 1 : -1);
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final userAccount = users[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                        vertical: AppPadding.halfPadding.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: userAccount.user.photo != null &&
                                userAccount.user.photo!.isNotEmpty
                            ? NetworkImage(userAccount.user.photo!)
                            : const AssetImage(
                                    'assets/images/profile_empty.png')
                                as ImageProvider,
                        onBackgroundImageError: (_, __) {
                          // Handle image load error
                        },
                      ),
                      title: Text(userAccount.user.name ?? 'No Name'),
                      subtitle: Text(userAccount.user.email ?? 'No Email'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userAccount.isActive == true
                                ? 'Approved'
                                : 'Pending',
                            style: TextStyle(
                              color: userAccount.isActive == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              context
                                  .read<NavigationCubit>()
                                  .updateSubMenuWithAnimated(
                                      context: context,
                                      subMenu: 'user_approval');
                              context
                                  .read<UserValidatorCubit>()
                                  .updateUser(userAccountenitity: userAccount);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is UserLoadFailure) {
              return Center(
                  child: Text('Failed to load users: ${state.message}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
