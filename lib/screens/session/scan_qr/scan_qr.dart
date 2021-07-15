import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../generated/l10n.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderWidth: 0,
            borderRadius: 15,
            cutOutSize: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
        Positioned(
            top: 60,
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  children: [
                    Text(
                      L.of(context).scanQR,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                    Wrap(
                      children: [
                        Text(
                          L.of(context).scanMessage,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
          left: 20,
          top: 20,
          child: SafeArea(
            child: IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              iconSize: 28,
              icon: const Icon(
                Icons.cancel,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
      });
    });
  }
}
