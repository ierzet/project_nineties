import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/admin/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/admin/presentation/cubit/user_validator_cubit.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';

class ViewUsersPage extends StatelessWidget {
  const ViewUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(const UserGetData());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadSuccess) {
            final users = state.data;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final userAccount = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: userAccount.user.photo != null &&
                              userAccount.user.photo!.isNotEmpty
                          ? NetworkImage(userAccount.user.photo!)
                          : const AssetImage('assets/images/profile_empty.png')
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
                          userAccount.isActive == true ? 'Approved' : 'Pending',
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
                                .updateSubMenuWithUser(
                                    'user_approval', userAccount);
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
    );
  }
}
