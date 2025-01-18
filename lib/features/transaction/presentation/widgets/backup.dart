// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:project_nineties/core/utilities/constants.dart';
// import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
// import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';

// class TransactionReview extends StatelessWidget {
//   const TransactionReview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MainAppBarNoAvatar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BlocBuilder<TransactionBloc, TransactionState>(
//           builder: (context, state) {
//             if (state is TransactionLoadMemberSuccess) {
//               final member = state.data;

//               return Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Center(
//                             child: CircleAvatar(
//                               radius: AppPadding.triplePadding.r * 3 / 2,
//                               backgroundImage: member.memberPhotoOfVehicle !=
//                                           null &&
//                                       member.memberPhotoOfVehicle!.isNotEmpty
//                                   ? NetworkImage(member.memberPhotoOfVehicle!)
//                                   : const AssetImage(
//                                           'assets/images/profile_empty.png')
//                                       as ImageProvider,
//                               onBackgroundImageError: (exception, stackTrace) {
//                                 debugPrint(
//                                     'Error loading image: $exception,${member.memberName} ');
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             member.memberName ?? 'No Name',
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 4,
//                               horizontal: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: member.memberStatusMember == true
//                                   ? Colors.green
//                                   : Colors.red,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Text(
//                               member.memberStatusMember == true
//                                   ? 'Active'
//                                   : 'Inactive',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Card(
//                             elevation: 4,
//                             child: ExpansionTile(
//                               title: const Text(
//                                 'Personal Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               children: [
//                                 const Divider(
//                                   height: 20,
//                                   thickness: 2,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.phone,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberPhoneNumber ??
//                                                 'No Phone',
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.male,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           Icon(
//                                             Icons.female,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberGender ?? 'No Data',
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.mail,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(member.memberEmail ?? 'No Data'),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Card(
//                             elevation: 4,
//                             child: ExpansionTile(
//                               title: const Text(
//                                 'Vehicle Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               children: [
//                                 const Divider(
//                                   height: 20,
//                                   thickness: 2,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.calendar_today,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Year: ',
//                                           ),
//                                           Text(
//                                             member.memberYearOfVehicle
//                                                 .toString(),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.motorcycle,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const Text(
//                                             ' Plate Number: ',
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberNoVehicle ?? 'No Data',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.directions_car_rounded,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Type : ',
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberTypeOfVehicle ??
//                                                 'No Data',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.business,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Brand : ',
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberBrandOfVehicle ??
//                                                 'No Data',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.height,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Size: ',
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberSizeOfVehicle ??
//                                                 'No Data',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_circle,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Variant: ',
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberColorOfVehicle ??
//                                                 'No Data',
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Card(
//                             elevation: 4,
//                             child: ExpansionTile(
//                               initiallyExpanded: true,
//                               title: const Text(
//                                 'Membership Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               children: [
//                                 const Divider(
//                                   height: 20,
//                                   thickness: 2,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.card_membership,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           const Text(
//                                             'Member Type: ',
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             member.memberSizeOfVehicle ??
//                                                 'No Data',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.app_registration,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             'Registration: ${member.memberExpiredDate != null ? DateFormat.yMMMd().format(member.memberExpiredDate!) : 'No Expiry Date'}',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.start,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             'Extend: ${member.memberExpiredDate != null ? DateFormat.yMMMd().format(member.memberExpiredDate!) : 'No Expiry Date'}',
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.edgesensor_high,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             'Expiry: ${member.memberExpiredDate != null ? DateFormat.yMMMd().format(member.memberExpiredDate!) : 'No Expiry Date'}',
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               Theme.of(context).colorScheme.primary,
//                           padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 AppPadding.defaultPadding.r),
//                           ),
//                           elevation: AppPadding.halfPadding.r / 2,
//                         ),
//                         onPressed: () {
//                           if (member.memberExpiredDate != null &&
//                                   member.memberExpiredDate!
//                                       .isBefore(DateTime.now()) ||
//                               member.memberStatusMember == false) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'This customer needs to extend first.'),
//                               ),
//                             );
//                             return;
//                           }

//                           final userAccountEntity =
//                               context.read<AppBloc>().state.user;
//                           context.read<TransactionBloc>().add(AddTransaction(
//                                 memberEntity: member,
//                                 userAccountEntity: userAccountEntity,
//                               ));
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           'Approve',
//                           style: AppStyles.buttonText.copyWith(
//                             color: Theme.of(context).colorScheme.onPrimary,
//                           ),
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               Theme.of(context).colorScheme.primary,
//                           padding: EdgeInsets.all(AppPadding.halfPadding.r * 3),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 AppPadding.defaultPadding.r),
//                           ),
//                           elevation: AppPadding.halfPadding.r / 2,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           'Extend',
//                           style: AppStyles.buttonText.copyWith(
//                             color: Theme.of(context).colorScheme.onPrimary,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             } else if (state is TransactionLoadFailure) {
//               return Center(
//                 child: Text('Error: ${state.message}'),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
// import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';

// class MemberQRView extends StatelessWidget {
//   const MemberQRView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: BarcodeScannerWithController(),
//     );
//   }
// }

// class BarcodeScannerWithController extends StatefulWidget {
//   const BarcodeScannerWithController({super.key});

//   @override
//   State<BarcodeScannerWithController> createState() =>
//       _BarcodeScannerWithControllerState();
// }

// class _BarcodeScannerWithControllerState
//     extends State<BarcodeScannerWithController> with WidgetsBindingObserver {
//   final MobileScannerController controller = MobileScannerController(
//     autoStart: false,
//     torchEnabled: true,
//   );

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     unawaited(controller.start());
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!controller.value.hasCameraPermission) {
//       return;
//     }

//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//         unawaited(controller.start());
//       case AppLifecycleState.inactive:
//         unawaited(controller.stop());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('With controller')),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             errorBuilder: (context, error, child) {
//               return ScannerErrorWidget(error: error);
//             },
//             fit: BoxFit.contain,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               height: 100,
//               color: const Color.fromRGBO(0, 0, 0, 0.4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ToggleFlashlightButton(controller: controller),
//                   StartStopMobileScannerButton(controller: controller),
//                   Expanded(
//                     child: Center(
//                       child: ScannedBarcodeLabel(
//                         barcodes: controller.barcodes,
//                       ),
//                     ),
//                   ),
//                   SwitchCameraButton(controller: controller),
//                   // AnalyzeImageFromGalleryButton(controller: controller),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Future<void> dispose() async {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//     await controller.dispose();
//   }
// }

// class ScannerErrorWidget extends StatelessWidget {
//   const ScannerErrorWidget({super.key, required this.error});

//   final MobileScannerException error;

//   @override
//   Widget build(BuildContext context) {
//     String errorMessage;

//     switch (error.errorCode) {
//       case MobileScannerErrorCode.controllerUninitialized:
//         errorMessage = 'Controller not ready.';
//       case MobileScannerErrorCode.permissionDenied:
//         errorMessage = 'Permission denied';
//       case MobileScannerErrorCode.unsupported:
//         errorMessage = 'Scanning is unsupported on this device';
//       default:
//         errorMessage = 'Generic Error';
//     }

//     return ColoredBox(
//       color: Colors.black,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(bottom: 16),
//               child: Icon(Icons.error, color: Colors.white),
//             ),
//             Text(
//               errorMessage,
//               style: const TextStyle(color: Colors.white),
//             ),
//             Text(
//               error.errorDetails?.message ?? '',
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ScannedBarcodeLabel extends StatelessWidget {
//   const ScannedBarcodeLabel({
//     super.key,
//     required this.barcodes,
//   });

//   final Stream<BarcodeCapture> barcodes;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: barcodes,
//       builder: (context, snapshot) {
//         final scannedBarcodes = snapshot.data?.barcodes ?? [];
//         final values = scannedBarcodes.map((e) => e.displayValue).join(', ');

//         if (scannedBarcodes.isEmpty) {
//           return const Text(
//             'Scan something!',
//             overflow: TextOverflow.fade,
//             style: TextStyle(color: Colors.white),
//           );
//         } else {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             context
//                 .read<TransactionBloc>()
//                 .add(GetMemberInformationCard(param: values));
//           });
//         }

//         return BlocBuilder<TransactionBloc, TransactionState>(
//           builder: (context, state) {
//             if (state is TransactionLoadMemberSuccess) {
//               final memberName = state.data.memberName ?? 'Unknown Member';
//               // Navigate to TransactionReview page
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 context.read<NavigationCubit>().updateSubMenuWithAnimated(
//                       context: context,
//                       subMenu: 'scan_qr',
//                     );
//               });
//               return Text(
//                 memberName,
//                 overflow: TextOverflow.fade,
//                 style: const TextStyle(color: Colors.white),
//               );
//             } else if (state is TransactionLoadFailure) {
//               return Text(
//                 'Error: ${state.message}',
//                 overflow: TextOverflow.fade,
//                 style: const TextStyle(color: Colors.white),
//               );
//             } else {
//               return const Text(
//                 'Loading...',
//                 overflow: TextOverflow.fade,
//                 style: TextStyle(color: Colors.white),
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }

// class ToggleFlashlightButton extends StatelessWidget {
//   const ToggleFlashlightButton({required this.controller, super.key});

//   final MobileScannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return const SizedBox.shrink();
//         }

//         switch (state.torchState) {
//           case TorchState.auto:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_auto),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.off:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_off),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.on:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_on),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.unavailable:
//             return const SizedBox.square(
//               dimension: 48.0,
//               child: Icon(
//                 Icons.no_flash,
//                 size: 32.0,
//                 color: Colors.grey,
//               ),
//             );
//         }
//       },
//     );
//   }
// }

// class StartStopMobileScannerButton extends StatelessWidget {
//   const StartStopMobileScannerButton({required this.controller, super.key});

//   final MobileScannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return IconButton(
//             color: Colors.white,
//             icon: const Icon(Icons.play_arrow),
//             iconSize: 32.0,
//             onPressed: () async {
//               await controller.start();
//             },
//           );
//         }

//         return IconButton(
//           color: Colors.white,
//           icon: const Icon(Icons.stop),
//           iconSize: 32.0,
//           onPressed: () async {
//             await controller.stop();
//           },
//         );
//       },
//     );
//   }
// }

// class SwitchCameraButton extends StatelessWidget {
//   const SwitchCameraButton({required this.controller, super.key});

//   final MobileScannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return const SizedBox.shrink();
//         }

//         final int? availableCameras = state.availableCameras;

//         if (availableCameras != null && availableCameras < 2) {
//           return const SizedBox.shrink();
//         }

//         final Widget icon;

//         switch (state.cameraDirection) {
//           case CameraFacing.front:
//             icon = const Icon(Icons.camera_front);
//           case CameraFacing.back:
//             icon = const Icon(Icons.camera_rear);
//         }

//         return IconButton(
//           color: Colors.white,
//           iconSize: 32.0,
//           icon: icon,
//           onPressed: () async {
//             await controller.switchCamera();
//           },
//         );
//       },
//     );
//   }
// }
