import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:bremen/route/route_constants.dart';

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
    this.text = 'QR코드를 스캔하여\n탑승을 시작하세요.'
  });

  final Stream<BarcodeCapture> barcodes;
  final String text;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isNotEmpty) {
          Navigator.pushReplacementNamed(
            context,
            gameLoadingPageRoute,
          );
          return PText(text, PFontStyle.headline2, textWhiteColor, semiboldInter);
        }

        return Text(
          scannedBarcodes.first.displayValue ?? 'No display value.',
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
