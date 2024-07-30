import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:project_nineties/features/transaction/presentation/widgets/listener_notification_transaction.dart';

class TransactionViewPage extends StatelessWidget {
  const TransactionViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TransactionBloc>().add(const TransactionGetData());
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(AppPadding.defaultPadding),
              child: Text(
                'My order',
                style: AppStyles.chartTitle,
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabBar(
                      indicatorColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      labelColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      tabs: const [
                        Tab(text: 'Delivered'),
                        Tab(text: 'Processing'),
                        Tab(text: 'Canceled'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 700, // Adjust the height as needed
                    child: TabBarView(
                      children: [
                        BuildOrderList(status: 'Delivered'),
                        Center(child: Text('Processing Orders')),
                        Center(child: Text('Canceled Orders')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ListenerNotificationTransaction(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoadDataSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        icon: const Icon(Icons.table_chart),
                        label: const Text('Export to Excel'),
                        onPressed: () {
                          context
                              .read<TransactionBloc>()
                              .add(TransactionExportToExcel(param: state.data));
                        }),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.file_present),
                      label: const Text('Export to CSV'),
                      onPressed: () {
                        context
                            .read<TransactionBloc>()
                            .add(TransactionExportToCSV(param: state.data));
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

class BuildOrderList extends StatelessWidget {
  const BuildOrderList({super.key, required this.status});

  final String status;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionLoadDataSuccess) {
          final transactions = state.data
              .where((transaction) => transaction.transactionStatus == '')
              .toList();

          if (transactions.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                elevation: 3,
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Order No: ${transaction.transactionId}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Date: ${DateFormat('dd MMM yyyy').format(transaction.transactionDate)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                          Text(
                              'Total Amount: \$${transaction.transactionAmount}'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text('Customer: ${transaction.customer.customerName}'),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to order details
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary, // Background color
                              foregroundColor: Colors.white, // Text color
                            ),
                            child: Text(
                              'Detail',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                          Text(
                            status,
                            style: TextStyle(
                              color: status == 'Delivered'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is TransactionLoadFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No orders found'));
        }
      },
    );
  }
}
