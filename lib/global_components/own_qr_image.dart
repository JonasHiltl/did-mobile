import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class OwnQrImage extends StatelessWidget {
  const OwnQrImage({required this.data, Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: data,
      size: 200.0,
      backgroundColor: const Color(0xFFf7fbff),
      foregroundColor: const Color(0xFF0B0C10),
    );
  }
}
