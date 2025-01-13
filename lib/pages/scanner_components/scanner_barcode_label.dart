import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
export 'package:provider/provider.dart';
import 'package:bremen/State/state_manager.dart';

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
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return Column(
            children: [
              PText(text, PFontStyle.headline2, textWhiteColor, semiboldInter),
              PText("hint: 아무 QR이나 스캔해 보세요", PFontStyle.label, textWhiteColor, semiboldInter)
            ],
          );
        }

        if (scannedBarcodes.first.displayValue!=null){
          globalState.setQR(scannedBarcodes.first.displayValue!);
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
