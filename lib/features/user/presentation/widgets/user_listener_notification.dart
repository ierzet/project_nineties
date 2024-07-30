import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';

class UserListenerNotification extends StatelessWidget {
  const UserListenerNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //notification user
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is UserLoadApprovalSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is UserLoadRegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is UserLoadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Container(),
        ),
      ],
    );
  }
}
