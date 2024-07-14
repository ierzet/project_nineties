import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';

class CustomersViewPage extends StatelessWidget {
  const CustomersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CustomerBloc>().add(const CustomerGetData());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerLoadDataSuccess) {
            final customers = state.data;

            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                final name = toTitleCase(customer.customerName ?? 'No Name');
                final initials = name.isNotEmpty
                    ? name.split(' ').map((e) => e[0]).take(2).join()
                    : 'NN';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(initials),
                    ),
                    title: Text(name),
                    subtitle: Text(customer.customerTypeOfMember ?? 'kosong?'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context
                            .read<NavigationCubit>()
                            .updateSubMenu('customer_update');
                        context
                            .read<CustomerValidatorBloc>()
                            .add(CustomerValidatorForm(params: customer));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is CustomerLoadFailure) {
            return Center(
                child: Text('Failed to load customers: ${state.message}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
