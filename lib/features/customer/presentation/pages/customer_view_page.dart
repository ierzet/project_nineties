import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_validator_bloc/customer_validator_bloc.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';

class CustomersViewPage extends StatelessWidget {
  const CustomersViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CustomerBloc>().add(const CustomerGetData());

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: Column(
        children: [
          const CustomerSearchWidget(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: AppPadding.defaultPadding.r,
                bottom: AppPadding.defaultPadding.r,
                right: AppPadding.defaultPadding.r,
                left: AppPadding.defaultPadding.r,
              ),
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
                        final name =
                            toTitleCase(customer.customerName ?? 'No Name');
                        final initials = name.isNotEmpty
                            ? name.split(' ').map((e) => e[0]).take(2).join()
                            : 'NN';

                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: AppPadding.halfPadding.h),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(initials),
                            ),
                            title: Text(name),
                            subtitle: Text(
                                customer.customerTypeOfMember ?? 'kosong?'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                context
                                    .read<NavigationCubit>()
                                    .updateSubMenuWithAnimated(
                                        context: context,
                                        subMenu: 'customer_update');
                                context.read<CustomerValidatorBloc>().add(
                                    CustomerValidatorForm(params: customer));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CustomerLoadFailure) {
                    return Center(
                        child:
                            Text('Failed to load customers: ${state.message}'));
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerSearchWidget extends StatefulWidget {
  const CustomerSearchWidget({super.key});

  @override
  _CustomerSearchWidgetState createState() => _CustomerSearchWidgetState();
}

class _CustomerSearchWidgetState extends State<CustomerSearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context
          .read<CustomerBloc>()
          .add(CustomerSearchEvent(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.doublePadding.r,
        bottom: 0,
        right: AppPadding.defaultPadding.r,
        left: AppPadding.defaultPadding.r,
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          hintText: 'Search ...',
          hintStyle: TextStyle(),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}
