import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_params.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_validator_bloc/partner_validator_bloc.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';

class PartnersViewPage extends StatelessWidget {
  const PartnersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PartnerBloc>().add(const PartnerGetData());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<PartnerBloc, PartnerState>(
        builder: (context, state) {
          if (state is PartnerLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PartnerLoadDataSuccess) {
            final partners = state.data;

            return ListView.builder(
              itemCount: partners.length,
              itemBuilder: (context, index) {
                final partner = partners[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: partner.partnerImageUrl != null &&
                              partner.partnerImageUrl!.isNotEmpty
                          ? NetworkImage(partner.partnerImageUrl!)
                          : const AssetImage('assets/images/profile_empty.png')
                              as ImageProvider,
                      onBackgroundImageError: (_, __) {
                        // Handle image load error
                      },
                    ),
                    title: Text(partner.partnerName ?? 'No Name'),
                    subtitle: Text(partner.partnerEmail ?? 'No Email'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context
                            .read<NavigationCubit>()
                            .updateSubMenu('partner_update');
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
          } else if (state is UserLoadFailure) {
            return Center(child: Text('Failed to load users: $state'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
