import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';

class ListenerNotificationPartner extends StatelessWidget {
  const ListenerNotificationPartner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartnerBloc, PartnerState>(
      listener: (context, state) {
        if (state is PartnerLoadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is PartnerLoadUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is PartnerLoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Container(), // You can wrap your UI widgets with BlocListener
    );
  }
}
