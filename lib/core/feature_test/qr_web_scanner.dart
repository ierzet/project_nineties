import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';

// class MyHome extends StatelessWidget {
//   const MyHome({super.key});

//   Widget _buildItem(BuildContext context, String label, Widget page) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => page,
//               ),
//             );
//           },
//           child: Text(label),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//         children: [
//           _buildItem(
//             context,
//             'MobileScanner Simple',
//             const BarcodeScannerSimple(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with ListView',
//             const BarcodeScannerListView(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with Controller',
//             const BarcodeScannerWithController(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with ScanWindow',
//             const BarcodeScannerWithScanWindow(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with Controller (return image)',
//             const BarcodeScannerReturningImage(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with zoom slider',
//             const BarcodeScannerWithZoom(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with PageView',
//             const BarcodeScannerPageView(),
//           ),
//           _buildItem(
//             context,
//             'MobileScanner with Overlay',
//             const BarcodeScannerWithOverlay(),
//           ),
//           _buildItem(
//             context,
//             'Analyze image from file',
//             const BarcodeScannerAnalyzeImage(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class QRCodeReaderWeb extends StatefulWidget {
  const QRCodeReaderWeb({super.key});

  @override
  State<QRCodeReaderWeb> createState() => _QRCodeReaderWebState();
}

class _QRCodeReaderWebState extends State<QRCodeReaderWeb> {
  final List<QRCodeCapture> list = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppPadding.defaultPadding.h,
        ),
        // QRCodeReaderSquareWidget(
        //   onDetect: (QRCodeCapture capture) =>
        //       setState(() => list.add(capture)),
        //   size: 250,
        // ),
        QRCodeReaderTransparentWidget(
          onDetect: (QRCodeCapture capture) =>
              setState(() => list.add(capture)),
          targetSize: 250,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              return ListTile(title: Text(list[index].raw));
            },
          ),
        ),
      ],
    );
  }
}
