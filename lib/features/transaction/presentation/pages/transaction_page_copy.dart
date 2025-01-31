import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';
import 'package:project_nineties/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:project_nineties/features/transaction/presentation/widgets/listener_notification_transaction.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MemberQRViewX extends StatefulWidget {
  const MemberQRViewX({super.key});

  @override
  State<MemberQRViewX> createState() => _MemberQRViewXState();
}

class _MemberQRViewXState extends State<MemberQRViewX> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoadMemberSuccess) {
            _showMemberInfoDialog(context, state.data);
          } else if (state is TransactionLoadFailure) {
            _showErrorDialog(context, state.message);
          }
        },
        child: Column(
          children: <Widget>[
            const ListenerNotificationTransaction(),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoadInProgress) {
                      return const CircularProgressIndicator();
                    } else if (state is TransactionLoadMemberSuccess) {
                      return result != null
                          ? AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText(
                                    'Getting member information . . .'),
                              ],
                              isRepeatingAnimation: true,
                            )
                          : const Text('Scan a code');
                    } else if (state is TransactionLoadFailure) {
                      return const Text('Error loading data');
                    } else {
                      return const Text('Scan a code');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (scanData.code != null) {
        context
            .read<TransactionBloc>()
            .add(GetMemberInformationCard(param: scanData.code!));
        controller.pauseCamera(); // Pause the camera to avoid multiple scans
      }
    });
  }

  void _showMemberInfoDialog(BuildContext context, MemberEntity member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final userAccountEntity = context.read<AppBloc>().state.user;
        return AlertDialog(
          title: const Text('Member Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Name:', member.memberName),
              _buildInfoRow('Email:', member.memberEmail),
              _buildInfoRow('Phone:', member.memberPhoneNumber),
              // Add more fields here if necessary
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  result = null;
                });
                context.read<TransactionBloc>().add(AddTransaction(
                      memberEntity: member,
                      userAccountEntity: userAccountEntity,
                    ));
                controller
                    ?.resumeCamera(); // Resume the camera after closing the dialog
                Navigator.of(context).pop();
                context
                    .read<NavigationCubit>()
                    .updateSubMenu('transaction_view');
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  result = null;
                });
                Navigator.of(context).pop();
                context
                    .read<NavigationCubit>()
                    .updateSubMenu('transaction_view');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
