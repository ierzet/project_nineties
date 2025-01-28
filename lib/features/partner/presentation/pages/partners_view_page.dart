import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';
import 'package:project_nineties/features/partner/presentation/cubit/partner_join_date_cubit.dart';

class PartnersViewPage extends StatelessWidget {
  const PartnersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final partnerBloc = context.read<PartnerBloc>();
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PartnerBloc, PartnerState>(
          builder: (context, state) {
            if (state is PartnerInitial) {
              partnerBloc.add(const PartnerGetData());
              return const Center(child: CircularProgressIndicator());
            } else if (state is PartnerLoadUpdateSuccess) {
              partnerBloc.add(const PartnerGetData());
              return const Center(child: CircularProgressIndicator());
            } else if (state is PartnerLoadSuccess) {
              partnerBloc.add(const PartnerGetData());
              return const Center(child: CircularProgressIndicator());
            } else if (state is PartnerLoadDataSuccess) {
              final partners = state.data;
              return ListView.builder(
                itemCount: partners.length,
                itemBuilder: (context, index) {
                  final partner = partners[index];
                  final initJoinDate =
                      partner.partnerJoinDate ?? DateTime.now();

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: partner.partnerImageUrl != null &&
                                partner.partnerImageUrl!.isNotEmpty
                            ? NetworkImage(partner.partnerImageUrl!)
                            : const AssetImage(
                                    'assets/images/profile_empty.png')
                                as ImageProvider,
                        onBackgroundImageError: (exception, stackTrace) {
                          debugPrint(
                              'Error loading image: $exception,${partner.partnerName} ');
                        },
                      ),
                      title: Text(partner.partnerName ?? 'No Name'),
                      subtitle: Text(partner.partnerEmail ?? 'No Email'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context
                              .read<PartnerJoinDateCubit>()
                              .onInitialDate(initJoinDate);
                          context
                              .read<NavigationCubit>()
                              .updateSubMenuWithAnimated(
                                  context: context, subMenu: 'partner_update');
                          context.read<PartnerValidatorBloc>().add(
                              PartnerValidatorForm(
                                  partnerParams: PartnerParams.fromPartnerModel(
                                      PartnerModel.fromEntity(partner))));
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (state is PartnerLoadFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load members: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PartnerBloc>().add(const PartnerGetData());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PartnerBloc, PartnerState>(
            builder: (context, state) {
              if (state is PartnerLoadDataSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        icon: const Icon(Icons.table_chart),
                        label: const Text('Export to Excel'),
                        onPressed: () {
                          context
                              .read<PartnerBloc>()
                              .add(PartnerExportToExcel(param: state.data));
                        }),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.file_present),
                      label: const Text('Export to CSV'),
                      onPressed: () {
                        context
                            .read<PartnerBloc>()
                            .add(PartnerExportToCSV(param: state.data));
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
