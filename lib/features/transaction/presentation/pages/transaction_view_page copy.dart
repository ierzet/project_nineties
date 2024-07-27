// import 'package:flutter/material.dart';

// class TransactionViewPage extends StatelessWidget {
//   const TransactionViewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: const Text(
//               'My order',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           DefaultTabController(
//             length: 3,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TabBar(
//                     indicatorColor: Theme.of(context).primaryColor,
//                     labelColor: Theme.of(context).primaryColor,
//                     unselectedLabelColor: Colors.black,
//                     tabs: const [
//                       Tab(text: 'Delivered'),
//                       Tab(text: 'Processing'),
//                       Tab(text: 'Canceled'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 700, // Adjust the height as needed
//                   child: TabBarView(
//                     children: [
//                       _buildOrderList(),
//                       const Center(child: Text('Processing Orders')),
//                       const Center(child: Text('Canceled Orders')),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemCount: 3, // Replace with the actual number of orders
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const Text(
//                   'Order No: 238562312',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8.0),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Date: 20/03/2020'),
//                     Text('Total Amount: \$150'),
//                   ],
//                 ),
//                 const SizedBox(height: 8.0),
//                 const Text('Customer: Customer Empat'),
//                 const SizedBox(height: 8.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     ElevatedButton(
//                       onPressed: () {
//                         // Navigate to order details
//                       },
//                       child: const Text('Detail'),
//                     ),
//                     const Text(
//                       'Delivered',
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
