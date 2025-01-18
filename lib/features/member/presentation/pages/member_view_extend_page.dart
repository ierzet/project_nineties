import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_bloc/member_bloc.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_validator_bloc/member_validator_bloc.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_dob_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_expired_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/cubit/member_join_date_cubit.dart';
import 'package:project_nineties/features/member/presentation/widgets/member_search.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';

class MembersViewExtendPage extends StatelessWidget {
  const MembersViewExtendPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MemberBloc>().add(const MemberGetData());

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: Column(
        children: [
          const MemberSearch(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppPadding.defaultPadding.r,
                horizontal: AppPadding.defaultPadding.r,
              ),
              child: BlocBuilder<MemberBloc, MemberState>(
                builder: (context, state) {
                  if (state is MemberLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MemberLoadDataSuccess) {
                    final members = state.data;

                    return ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];
                        final initExpiredDate =
                            member.memberExpiredDate ?? DateTime.now();
                        final initJoinDate =
                            member.memberJoinDate ?? DateTime.now();
                        final initDOBDate =
                            member.memberDateOfBirth ?? DateTime.now();
                        final name =
                            toTitleCase(member.memberName ?? 'No Name');
                        final initials = name.isNotEmpty
                            ? name.split(' ').map((e) => e[0]).take(2).join()
                            : 'NN';

                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: AppPadding.halfPadding.h),
                          child: ListTile(
                            leading: member.memberPhotoOfVehicle != null &&
                                    member.memberPhotoOfVehicle!.isNotEmpty
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        member.memberPhotoOfVehicle!),
                                  )
                                : CircleAvatar(
                                    child: Text(initials),
                                  ),
                            title: Text(name),
                            subtitle:
                                Text(member.memberTypeOfMember ?? 'kosong?'),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    member.memberJoinPartner?.partnerName ??
                                        'No Partner',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  member.memberStatusMember == true
                                      ? 'Active'
                                      : 'Inactive',
                                  style: TextStyle(
                                    color: member.memberStatusMember == true
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ), // Add space between the text and the icon
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    context
                                        .read<NavigationCubit>()
                                        .updateSubMenuWithAnimated(
                                            context: context,
                                            subMenu: 'member_extend');
                                    context.read<MemberValidatorBloc>().add(
                                        MemberValidatorForm(
                                            params:
                                                member.copyWith(memberId: '')));

                                    // Setup date default value
                                    context
                                        .read<MemberExpiredDateCubit>()
                                        .onInitialDate(initExpiredDate);
                                    context
                                        .read<MemberJoinDateCubit>()
                                        .onInitialDate(initJoinDate);
                                    context
                                        .read<MemberDOBDateCubit>()
                                        .onInitialDate(initDOBDate);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is MemberLoadFailure) {
                    return Center(
                        child:
                            Text('Failed to load members: ${state.message}'));
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ),
          // const ListenerNotificationMember(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MemberBloc, MemberState>(
            builder: (context, state) {
              if (state is MemberLoadDataSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        icon: const Icon(Icons.table_chart),
                        label: const Text('Export to Excel'),
                        onPressed: () {
                          context
                              .read<MemberBloc>()
                              .add(MemberExportToExcel(param: state.data));
                        }),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.file_present),
                      label: const Text('Export to CSV'),
                      onPressed: () {
                        context
                            .read<MemberBloc>()
                            .add(MemberExportToCSV(param: state.data));
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
